class BooksController < ApplicationController
    
    def index
        @books = Book.all
    end
    
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = "successfully submitted the book!"
            redirect_to user_path(@book.user_id)
        else
            render :index
        end
    end
    
    def show
        @book = Book.find(params[:id])
    end
    
    def edit
        @book = Book.find(params[:id])
        # @userの作成から
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
        params.permit(:title, :body)
    end
    
    def book_update_params
        params.require(:book).permit(:title, :body)
    end
end
