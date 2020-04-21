class ProductsController < ApplicationController

	def index
		@genres = set_genres
		@products = Product.all
		@count = @genres.active&&@products.active.count
		@name = "商品"
		if params[:genre_id]
			@genre = Genre.find(params[:genre_id])
			@name = @genre.name
			@products = @genre.products.order(created_at: :desc).all
			@count = @products.count
		else
			@products = Product.order(created_at: :desc).all
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
