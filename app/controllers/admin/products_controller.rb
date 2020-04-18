class Admin::ProductsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end

	def new
		@product = Product.new
	end

	def create
		product = Product.new(product_params)
		if  product.save
			redirect_to admin_product_path(product), notice: "商品が登録されました"
		else
			redirect_to new_admin_product_path, notice: "空欄があります"
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		product =Product.find(params[:id])
		if product.update(product_params)
			redirect_to admin_product_path(product),notice: "商品編集が完了しました"
		else
			redirect_to edit_admin_product_path,notice: "空欄があります"
		end
	end


	private


	def product_params
		params.require(:product).permit(:genre_id,:name,:introduction,:price,:image,:sale_status, :recommend_status)
	end
end
