class Admin::MembersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@members = Member.all
		@member = Member.find(params[:id])
	end

	def show
		@member = Member.find(params[:id])
	end

	def edit

	end

	def update

	end
end
