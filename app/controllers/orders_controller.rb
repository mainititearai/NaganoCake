class OrdersController < ApplicationController

	def index
	end

	def show
	end

	def new
		@order = Order.new
	end

	def confirm
		@order = Order.new
		@order.payment_method = params[:order_info][:payment_method]
		#自分の住所
		if params[:order_info][:address_kind] == "self_address"
		@order.address = current_member.address
		@order.postcode = current_member.postcode
		@order.name = current_member.last_name+current_member.first_name
		elsif params[:order_info][:address_kind] == "other_address"
		@shipping_address = ShippingAddress.find(params[:order_info][:other_address_id])
		@order.address = @shipping_address.address
		@order.postcode = @shipping_address.postcode
		@order.name = @shipping_address.name
		elsif params[:order_info][:address_kind] == "new_address"
		@order.address = params[:order_info][:new_address]
		@order.postcode = params[:order_info][:new_postcode]
		@order.name = params[:order_info][:new_name]
		end
		@cart_items = current_member.cart_items.all
	end

	def create
	end

	def thanks
	end

end
