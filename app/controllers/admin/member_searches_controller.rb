class Admin::MemberSearchesController < ApplicationController


	def index
    members = Member.search(params[:search]).limit(132)
    @members = members.page(params[:pages]).per(10)
    @search = params[:search]
  end

end
