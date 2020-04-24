class Admin::MembersController < ApplicationController
	before_action :authenticate_admin!

	def index
		members = Member.all
		@members = members.page(params[:page]).per(15)
	end

	def show
		@member = Member.find(params[:id])
	end

	def edit
		@member = Member.find(params[:id])
	end

	def update
		@member = Member.find(params[:id])
		@member.update(member_params)
		redirect_to admin_member_path

	end

	  private
	  def member_params
 	 	params.require(:member).permit(:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:address,:postcode,:phone_number,:valid_status)
	  end
end
