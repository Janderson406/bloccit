class CommentsController < ApplicationController

   before_action :require_sign_in
   before_action :authorize_user, only: [:destroy] #unauthorized users are not permitted to delete comments

   def create
     @post = Post.find(params[:post_id])
     @comment = @post.comments.new(comment_params)
     @comment.user = current_user
     #find the correct post using post_id and then create a new comment using comment_params. We assign the comment's user to current_user, which returns the signed-in user instance.
     @new_comment = Comment.new
      #render a new form partial, with a new instance of a comment to clear the comment form, then use the new variable in the create.js.erb file

     if @comment.save
       flash[:notice] = "Comment saved successfully."

     else
       flash[:alert] = "Comment failed to save."

     end

     respond_to do |format|
       format.html
       format.js
     end
   end


   def destroy
     @post = Post.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
     #replace comment with @comment because we'll need to have access to the variable in our .js.erb view
     if @comment.destroy
       flash[:notice] = "Comment was deleted."
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
     end

     respond_to do |format|
       format.html
       format.js
     end
      #the respond_to block gives our controller action the ability to return different response types,
      #depending on what was asked for in the request. The controller's response is unchanged if the
      #client requests HTML, but if the client requests JavaScript, the controller will render .js.erb instead.
   end


   private

 #define a private comment_params method that white lists the parameters we need to create comments.
   def comment_params
     params.require(:comment).permit(:body)
   end

   #allow the comment owner or an admin user to delete the comment.
   def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       redirect_to [comment.post.topic, comment.post]
     end
   end

 end
