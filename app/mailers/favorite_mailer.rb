class FavoriteMailer < ApplicationMailer
  default from: "jondanderson@gmail.com"

  def new_comment(user, post, comment)

    #set three different headers to enable conversation threading in different email clients.
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end


  def new_post(user, post)
    headers["Message-ID"] = "<posts/#post.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    #@comment = comment

    mail(to: user.email, subject: "The new post titled: #{post.title} has been favorited" )

  end
end


##ActionMailer follows a similar pattern as Rails controllers; you can define
#instance variables that will be available to your "view" - which is the content sent in the email in this context.
