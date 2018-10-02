class NotificationMailer < ApplicationMailer
  def notification_mail(post)
   @post = post
   current_user_email = @post.user.email
   mail to: @post.user.email, subject: "投稿完了メール"
  end
end
