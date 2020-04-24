class SearchesController < ApplicationController
	def index
		products = Product.search(params[:search]).limit(132)
		@products = products.page(params[:pages]).per(10)
		@searches = params[:search]
		@genres = Genre.all
		@count = @genres.active&&@products.count
	end
end
