class BookmarksController < ApplicationController
  def create
    bookmark = Bookmark.new(bookmark_params)
    post = bookmark.post
    if bookmark.save
      flash[:notice] = "いいねしました!"
      redirect_to post_path(post)
    else
      flash.now[:alert] = bookmark.errors.full_messages
      render "post/show", status: :unprocessable_entity
    end
  end

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :post_id )
  end
end
