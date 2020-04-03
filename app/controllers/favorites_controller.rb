class FavoritesController < ApplicationController
	def create
		# @favorite = Favorite.create(user_id: current_user.id, book_id: params[:book_id])
		# @favorites = Favorite.where(book_id: params[:book_id])
		# @books = Book.all
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: book.id)
		favorite.save
		redirect_to books_path
	end

	def destroy
		# Favorite = Favorite.find_by(user_id: current_yser.id, book_id: params[:book_id])
		# favorite.destroy
		# @favorites = Favorite.where(book_id: params[:book_id])
		# @books = Book.all

		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		favorites = Favorite.where(book_id: params[:book_id])
		# redirect_to books_path
	end

end
