class UsersController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    # imageに指定がないとき、デフォルト画像を使う
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      redirect_to @user
      flash[:success] = "My Pageを更新しました" 
     else
      render'edit'
     end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites_posts = @user.favorite_posts
    
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :password,
                                 :password_confirmation)
  end
  
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end
end
