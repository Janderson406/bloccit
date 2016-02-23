class TopicsController < ApplicationController


 before_action :require_sign_in, except: [:index, :show]
 #require_sign_in method from ApplicationController to redirect guest users who attempt to access controller actions other than index or show
 before_action :authorize_user, except: [:index, :show]
 #check the role of signed-in users. If the current_user isn't an admin, we'll redirect them to the topics index view

  def index
       @topics = Topic.all
  end


  def show
     @topic = Topic.find(params[:id])
  end


  def new
     @topic = Topic.new
  end


  def create
     #@topic = Topic.new
     #@topic.name = params[:topic][:name]
     #@topic.description = params[:topic][:description]
     #@topic.public = params[:topic][:public]
     #REFACTORED =>
     @topic = Topic.new(topic_params) #see bottom of file

     if @topic.save
       @topic.labels = Label.update_labels(params[:topic][:labels])
       #pass Label the labels associated with the current topic
       redirect_to @topic, notice: "Topic was saved successfully."
     else
       flash.now[:alert] = "Error creating topic. Please try again."
       render :new
     end
   end


   def edit
     @topic = Topic.find(params[:id])
   end

   def update
     @topic = Topic.find(params[:id])

     #@topic.name = params[:topic][:name]
     #@topic.description = params[:topic][:description]
     #@topic.public = params[:topic][:public]
     #REFACTORED =>
     @topic.assign_attributes(topic_params) #see bottom of file

     if @topic.save
        flash[:notice] = "Topic was updated."
       redirect_to @topic
     else
       flash.now[:alert] = "Error saving topic. Please try again."
       render :edit
     end
   end


   def destroy
     @topic = Topic.find(params[:id])

     if @topic.destroy
       flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the topic."
       render :show
     end
   end

   private

   def topic_params
     params.require(:topic).permit(:name, :description, :public)
   end

    #define authorize_user, used to redirect non-admin users to topics_path
     def authorize_user
       unless current_user.admin?
         flash[:alert] = "You must be an admin to do that."
         redirect_to topics_path
       end
     end


end
