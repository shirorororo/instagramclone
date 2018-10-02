class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
     @posts = Post.all 
  end


  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      NotificationMailer.notification_mail(@post).deliver  ##追記
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to controller: 'users', action: 'show', id:current_user.id, notice: "作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    render :new if @post.invalid?
  end
  
  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)

  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to controller: 'users', action: 'show', id:current_user.id, notice: "編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to controller: 'users', action: 'show', id:current_user.id, notice:"削除しました！"
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :image, :image_cache)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
end
