class PostsController < ApplicationController
  def index
    @page = (params[:page].to_i > 0) ? params[:page].to_i : 1
    @search = Post.ransack(params[:q])
    @posts = @search.result(distinct: true).includes(:user).offset((@page - 1)*(Post.pagination_per_page)).limit(Post.pagination_per_page)
    @total_posts = @search.result(distinct: true).includes(:user).count
    @previous_page = @page > 1 ? @page - 1 : nil
    @next_page = @total_posts > @page * (Post.pagination_per_page) ? @page + 1 : nil
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user = current_user
    if post.save
      flash[:notice] = t("flash.posts.create.success")
      redirect_to posts_path
    else
      flash.now[:alert] = post.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    binding.pry
    @post = Post.includes(:user).find(params[:id])
    @comment = @post.comments.build
    @comments = @post.comments.includes(:user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = t("flash.posts.update.success")
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.delete
      flash[:notice] = t("flash.posts.destroy.success")
      redirect_to posts_path
    else
      flash.now[:alert] = post.errors.full_messages
      render :index, status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
