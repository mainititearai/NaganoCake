class HomeController < ApplicationController

	def top
		@products = Product.where(recommend_status: "recommend")
	end

	def about
	end
end
