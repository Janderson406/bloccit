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


  def update
    user = User.find(params[:id])

    if user.update_attributes(user_params)
      render json: user.to_json, status: 200
    else
      render json: {error: "User update failed", status: 400}, status: 400
    end
  end
  #render user as JSON with a 200 OK status. Otherwise, we'll render a JSON error with the appropriate status.


 def create
   user = User.new(user_params)

   if user.valid?
     user.save!
     render json: user.to_json, status: 201
   else
     render json: {error: "User is invalid", status: 400}, status: 400
   end
 end


  private
  #define user_params to whitelist user parameters.
  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
