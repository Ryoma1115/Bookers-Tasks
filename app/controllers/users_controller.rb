class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :screen_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "You have updated user successfully."
    else
      render 'edit'
    end
  end

  def follows
      @title = "Follow Users"
      @book = Book.new
      @user = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @title = "Followers"
    @book = Book.new
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
    def screen_user
      unless params[:id].to_i == current_user.id
        redirect_to user_path(current_user)
      end
    end
end
