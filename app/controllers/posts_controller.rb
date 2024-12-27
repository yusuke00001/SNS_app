class PostsController < ApplicationController
  def index
  end

  def new
    @posts = Post.new
  end

  def create
  end
end
