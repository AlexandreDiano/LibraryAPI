module Api
  class BooksController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

    def index
      books = Book.all
      render json: { books: books }
    end

    def show
      render json: { books: book }
    end

    def create
      new_book = Book.new(book_params)
      if new_book.save
        render json: { book: new_book }
      else
        render json: { errors: new_player.errors }, status: 500
      end
    end

    def update
      if book.update_attributes(book_params)
        render json: { book: new_book }
      else
        render json: { errors: new_player.errors }, status: 500
      end
    end

    def destroy
      if book.destroy!
        render json: { book: new_book }
      else
        render json: { errors: new_player.errors }, status: 500
      end
    end

    private

    def book_params
      params.require(:book).permit(:title, :description, :gender)
    end

    def book
      @book ||= Book.find_by!(id: id)
    end

    def id
      params.require(:id)
    end

    def record_not_found
      render json: { errors: ["Couldn't find Book {id: #{id}}"] }, status: 500
    end
  end
end
