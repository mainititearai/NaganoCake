class MembersController < ApplicationController

	def show
		@member = current_member
	end

	def edit
		@member = current_member
	end

	def update
		@member = current_member
		if @member.update(member_params)
			redirect_to member_path
		else
			render 'member_path'
		end
	end

	def cancel
		@member = current_member
	end

	def withdraw
		@member = current_member
		@member.withdraw!
		reset_session
		redirect_to root_path
	end

	  private
	  def member_params
 	 	params.require(:member).permit(:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:address,:postcode,:phone_number,:valid_status)
	  end

end