class BookmarksController < ApplicationController
  def index
    @search = current_user.bookmarks.ransack(params[:q])
    @page = (params[:page].to_i > 0) ? params[:page].to_i : 1
    @bookmarks = @search.result(distinct: true).includes(:post)
    @bookmarks = @bookmarks.offset((@page - 1) * Post.pagination_per_page).limit(Post.pagination_per_page)
    @total_posts = @bookmarks.count
    @previous_page = @page > 1 ? @page - 1 : nil
    @next_page = @total_posts > @page * Post.pagination_per_page ? @page + 1 : nil
  end
  def create
    bookmark = Bookmark.new(bookmark_params)
    post = bookmark.post
    if bookmark.save
      flash[:notice] = "いいねしました!"
      redirect_to post_path(post)
    else
      flash[:alert] = "すでにいいねされています！"
      redirect_to post_path(post)
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    if bookmark.delete
      flash[:notice] = "いいねを解除しました"
      redirect_to bookmarks_path
    else
      flash[:alert] = bookmark.errors.full_messages
      redirect_to bookmarks_path
    end
  end

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :post_id)
  end
end
