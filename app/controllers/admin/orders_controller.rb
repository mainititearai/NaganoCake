class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@orders = Order.all.reverse_order
	end

	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items.all
		@sum = 0
		# @order_item = OrderItem.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		@order_items = @order.order_items.all
		@order.update(order_params)
		if @order.order_status == "confirm"
	       @order_items.update_all(production_status: "waiting")
    	end
		redirect_back(fallback_location: root_url)
	end

	def item_update
		@order_item = OrderItem.find(params[:id])
		@order = Order.find_by(id: @order_item.order_id)
		@order_item.update(order_item_params)
		@order_items = @order.order_items.where.not(production_status: "completed")

		if @order_item.production_status == "working"
    	   @order.update(order_status: "in_production")
    	elsif @order_items.empty?
    	@order.update(order_status: "preparation")
    	end
		redirect_back(fallback_location: root_url)
	end


	def order_params
		params.require(:order).permit(:member_id,:name, :postcode, :address, :payment_method, :order_status)
	end
	def order_item_params
		params.require(:order_item).permit(:order_id, :product_id, :quantity, :price, :production_status)
	end

end
