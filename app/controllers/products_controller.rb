class ProductsController < ApplicationController

	def index
		@products = Product.all
		@genres = set_genres
		if params[:genre_id]
			@genre = Genre.find(params[:genre_id])
			@products = @genre.products.order(created_at: :desc).all
		else
			@products = Product.order(created_at: :desc).all
		end
	end

	def show
		@product = Product.find(params[:id])
		@cart_item = CartItem.new
		@genre = set_genres
	end

	private

	def set_genres
		genres = Genre.all
	end
end
