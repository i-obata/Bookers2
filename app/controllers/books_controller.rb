class BooksController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]
    
    def index
        @books = Book.all
        @book = Book.new
        @user = current_user
    end
    
    def create
        @book = Book.new(book_params)
        @user = current_user
        @book.user_id = current_user.id
        @books = Book.all
        if @book.save
            flash[:notice] = "successfully submitted the book!"
            redirect_to book_path(@book.id)
        else
            render :index
        end
    end
    
    def show
        @book = Book.find(params[:id])
        @booknew =Book.new
        @user = User.find_by(id: @book.user_id)
    end
    
    def edit
        @book = Book.find(params[:id])
    end
    
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "successfully edited the book!"
            redirect_to book_path(@book.id)
        else
            render :edit
        end
    end
    
    def destroy
        book =Book.find(params[:id])
        if book.destroy
            flash[:notice] = "The book was successfully destroyed."
            redirect_to books_path
        end
    end
    
    private
    
    def book_params
        params.require(:book).permit(:title, :body)
    end
    
    def is_matching_login_user
        book = Book.find(params[:id])
        user = User.find_by(id: book.user_id)
        unless user.id == current_user.id
            redirect_to books_path
        end
    end
end
