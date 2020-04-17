class Admin::MembersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@members = Member.all
	end

	def show

	end

	def edit

	end

	def update

	end
end
