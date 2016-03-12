class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user
  before_action :authorize_user

  def show
    user = User.find(params[:id])
    render json: user.to_json, status: 200
  end
  #The show action in this controller is similar to our non-API UsersController in that it finds a user based on the id.
  #Unlike our non-API UsersController, this show action renders the user object it finds as JSON and returns an HTTP status code of 200 (success).

  def index
    users = User.all
    render json: users.to_json, status: 200
  end
  #the index action which renders all users as JSON.

end
