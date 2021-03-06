class OrdersController < ApplicationController
	before_action :cart_items_blank, only: [:new, :confirm]

	def index
		orders = current_member.orders.all.reverse_order
		@orders = orders.page(params[:page]).per(10)
		@sum = 0
	end

	def show
		@order = Order.find(params[:id ])
		@sum = 0

	end

	def new
		cart_items = current_member.cart_items.all
		@sum = 0
		cart_items.each do |cart_item|
			sub_total = (cart_item.product.price*1.1*cart_item.quantity).floor
			@sum += sub_total
		end
		@total = @sum+800
		@order = Order.new
		@shipping_addresses = ShippingAddress.where(member_id:current_member.id)
	end

	def confirm
		@amount = params[:amount]
		@pay = params['payjp-token']
		@order = Order.new
		@order.payment_method = params[:order_info][:payment_method]
		@sum = 0
		#自分の住所
		if params[:order_info][:address_kind] == "self_address"
		@select = "self"
		@order.address = current_member.address
		@order.postcode = current_member.postcode
		@order.name = current_member.last_name+current_member.first_name
		elsif params[:order_info][:address_kind] == "other_address"
		@select = "other"
		@shipping_address = ShippingAddress.find(params[:order_info][:other_address_id])
		@order.address = @shipping_address.address
		@order.postcode = @shipping_address.postcode
		@order.name = @shipping_address.name
		elsif params[:order_info][:address_kind] == "new_address"
		@select = "new"
		@order.address = params[:order_info][:new_address]
		@order.postcode = params[:order_info][:new_postcode]
		@order.name = params[:order_info][:new_name]
		end
		@cart_items = current_member.cart_items.all
	end

	def create
		@pay = params['payjp-token']
		if @pay.present?
			Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    		Payjp::Charge.create(
      		:amount => params[:amount],
      		:card => params['payjp-token'],
      		:currency => 'jpy'
      		)
    	end
		@order = Order.new(order_params)
		@select = params[:select]
		@member = current_member
		@order.save
		#ここに新規お届け先を登録した場合、配送先一覧に保存される動きを追加する！！！
		if @select == "new"
			@shipping_address = ShippingAddress.new
			@shipping_address.member_id = current_member.id
			@shipping_address.name = @order.name
			@shipping_address.postcode = @order.postcode
			@shipping_address.address = @order.address
			@shipping_address.save
		end
		@cart_items = @member.cart_items.all
		# 一つ上で全件取得したquantityを１件ずつ取得するeach文
		@cart_items.each do |cart_item|
		@order_item = OrderItem.new
		@order_item.order_id = @order.id
		@order_item.product_id = cart_item.product_id
		@order_item.quantity = cart_item.quantity
		@order_item.price = cart_item.product.price
		@order_item.save
		end
		current_member.cart_items.destroy_all
	end


	def order_params
		params.require(:order).permit(:member_id,:name, :postcode, :address, :payment_method, :order_status)
	end

	def cart_items_blank
		if current_member.cart_items.blank?
			redirect_to member_products_path
		end
	end
end
