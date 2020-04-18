class Admin::GenresController < ApplicationController
	before_action :authenticate_admin!

	def index
		@genres = Genre.all
		@genre = Genre.new
	end

	def create
		genre = Genre.new(genre_params)
		if  genre.save
			redirect_to admin_genres_path, notice: "登録しました"
		else
			@genres = Genre.all
			@genre = Genre.new
			redirect_to admin_genres_path, notice: "ジャンル名を入力してください"
		end
	end

	def edit
		@gerne = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		if  @genre.update(genre_params)
			redirect_to admin_genres_path,notice: "編集完了しました"
		else
			redirect_to edit_admin_genre_path,notice: "空欄があります"
		end
	end

	private

	def genre_params
		params.require(:genre).permit(:name,:valid_status)
	end
end
