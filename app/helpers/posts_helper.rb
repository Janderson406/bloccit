module PostsHelper
  def user_is_authorized_for_post?(post)
        current_user && (current_user == post.user || current_user.admin?)
   end
end

#we only want to display the "Edit Post" and "Delete Post" links to the creator of the post or admin users.
#authorize_user_for_post checks if there is a signed-in current_user, and if that current_user either owns the post, or is an admin.
