class HomeController < ApplicationController

	def top
		@genres = Genre.all
		@products = Product.where(recommend_status: "recommend")
	end

	def about
	end

	def wait
	end

	def change_password
	end
end
