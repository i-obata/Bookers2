class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    
    # サイドバーにカレントユーザ以外が表示された状態で
    # editを処理した場合はshowを処理する
    if @user.id =! current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "successfully edited the user!"
    redirect_to user_path(@user.id)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
  
end
