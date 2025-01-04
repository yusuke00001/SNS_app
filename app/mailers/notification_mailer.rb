class NotificationMailer < ApplicationMailer
  def new_comment_notification(user, post, comment)
    @user = user
    @post = post
    @comment = comment
    mail(to: @user.email, subject: "あなたの投稿にコメントがつきました")
  end

  def new_bookmark_notification(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "あなたの投稿にいいねがつきました")
  end
end
