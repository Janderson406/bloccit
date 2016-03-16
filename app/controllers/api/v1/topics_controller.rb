class Api::V1::TopicsController < Api::V1::BaseController
# #22
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]
  #we want un-authorized/authenticated users to still be able to fetch a topic or all topics, per our access rules

    def index
      topics = Topic.all
      render json: topics.to_json, status: 200
    end
    #the index action which renders all topics as JSON.

    def show
      topic = Topic.find(params[:id])
      render json: topic.to_json, status: 200
    end
    #The show action in this controller is similar to our non-API TopicsController in that it finds a topic based on the id.
    #Unlike our non-API TopicsController, this show action renders the user object it finds as JSON and returns an HTTP status code of 200 (success).

    def update
      topic = Topic.find(params[:id])

      if topic.update_attributes(topic_params)
        render json: topic.to_json, status: 200
      else
        render json: {error: "Topic update failed", status: 400}, status: 400
      end
    end

    def create
      topic = Topic.new(topic_params)

      if topic.valid?
        topic.save!
        render json: topic.to_json, status: 201
      else
        render json: {error: "Topic is invalid", status: 400}, status: 400
      end
    end

    def destroy
      topic = Topic.find(params[:id])

      if topic.destroy
        render json: {message: "Topic destroyed", status: 200}, status: 200
      else
        render json: {error: "Topic destroy failed", status: 400}, status: 400
      end      
    end

    private
    def topic_params
      params.require(:topic).permit(:name, :description, :public)
    end

  end
