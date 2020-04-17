class ProductsController < ApplicationController

	def index
		@products = Product.all
		@genre = set_genre
	end

	def show
		@product = Product.find(params[:id])
		@cart_item = CartItem.new
		@genre = set_genre
	end

	private

	def set_genre
		genre = Genre.all
	end
end
