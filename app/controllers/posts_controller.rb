class PostsController < ApplicationController

  before_action :require_sign_in, except: :show
  #before_action filter to redirect guest users from actions they won't be able to access (except for show)

  before_action :authorize_user, except: [:show, :new, :create]
  #before_action filter to check the role of a signed-in user. If the current_user isn't authorized based on their role, we'll redirect them to the posts show view.

  #def index
  #  @posts = Post.all  << no longer an index route for posts. All posts displayed with respect to a topic now, on the topics show view.
  #end


  def show
    @post = Post.find(params[:id])
    #find the post that corresponds to the id in the params that was passed to show &
    #assign it to @post. Unlike in the index method, in the show method,
    #populate an instance variable with a single post, rather than a collection of posts.
  end


  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    #create an instance variable, @post, then assign it an empty post returned by Post.new
  end


  def create
    #When the user clicks Save, the create method is called. create either updates the database
    #with the save method, or returns an error. Unlike new, create does not have a corresponding view.
    #create works behind the scenes to collect the data submitted by the user and update the database. create is a POST action.
      #REFACTORED TO =>
        #@post = Post.new
        #@post.title = params[:post][:title]
        #@post.body = params[:post][:body]
        @topic = Topic.find(params[:topic_id])
        #@post.topic = @topic #assign a topic to a post.
        @post = @topic.posts.build(post_params) #see bottom of file
        @post.user = current_user #assign @post.user in the same way we assigned @post.topic, to properly scope the new post.



     if @post.save
       flash[:notice] = "Post was saved."
       redirect_to [@topic, @post] #change the redirect to use the nested post path
       #if we successfully save Post to the database, we display a success message
       #using flash[:notice]and redirect the user to the route generated by @post.
       #Redirecting to @post will direct the user to the posts show view.
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :new
       #if we do not successfully save Post to the database,
       #we display an error message and render the new view again.
     end
   end


  def edit
    @post = Post.find(params[:id])
  end


  def update
     @post = Post.find(params[:id])
     #@post.title = params[:post][:title]
     #@post.body = params[:post][:body]
     #REFACTORED =>
     @post.assign_attributes(post_params)


     if @post.save
       flash[:notice] = "Post was updated."
       redirect_to [@post.topic, @post] #change the redirect to use the *nested* post path
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :edit
     end
   end

   def destroy
     @post = Post.find(params[:id])

     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @post.topic #when a post is deleted, we direct users to the topic show view
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
     #call destroy on @post.
     #If that call is successful, we set a flash message and redirect the user to the posts index view.
     #If destroy fails then we redirect the user to the show view using render :show
   end

   private
   #add private methods to the bottom of the file. Any method defined below private, will be private.
   def post_params
     params.require(:post).permit(:title, :body)
   end

   def authorize_user
     post = Post.find(params[:id])
     #redirect the user unless they own the post they're attempting to modify, or they're an admin.
     unless current_user == post.user || current_user.admin? || current_user.moderator?
       flash[:alert] = "You must be an admin or mod to do that."
       redirect_to [post.topic, post]
     end
   end

end
