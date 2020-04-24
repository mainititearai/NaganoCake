class ProductsController < ApplicationController

	def index
		@genres = set_genres
		@products = Product.page(params[:page]).per(12)
		@count = @genres.active&&@products.count
		@name = "商品"
		@oddnum = 1
		@evennum = 1
		if params[:genre_id]
			@genre = Genre.find(params[:genre_id])
			@name = @genre.name
			products = @genre.products.order(created_at: :desc).all
			@products = products.page(params[:page]).per(12)
			@count = @products.count
		else
			products = Product.order(created_at: :desc).all
			@products = products.page(params[:page]).per(12)
		end
	end

	def show
		@product = Product.find(params[:id])
		@cart_item = CartItem.new
		@genres = set_genres
	end

	private

	def set_genres
		genres = Genre.all
	end
end
