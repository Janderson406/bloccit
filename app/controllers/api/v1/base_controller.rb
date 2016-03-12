
 class Api::V1::BaseController < ApplicationController
   skip_before_action :verify_authenticity_token
   #skip the Rails verify_authenticity_token method which provides RequestForgeryProtection. If we don't skip it, we won't be able to make API calls from other domains.

   rescue_from ActiveRecord::RecordNotFound, with: :not_found
   rescue_from ActionController::ParameterMissing, with: :malformed_request
   #we use rescue_from to catch any ActiveRecord::RecordNotFound exception that occurs and execute the not_found method in Api::V1::BaseController if the exception does occur.
   #Similarly, we catch ActionController::ParameterMissing exceptions and execute malformed_request.


   def authenticate_user
     authenticate_or_request_with_http_token do |token, options|
       @current_user = User.find_by(auth_token: token)
     end
   end
   #authenticate_or_request_with_http_token method. This method checks the request for authorization headers and passes them to the proceeding block.
   #We then use the token to find the user and set @current_user, thereby authenticating them.

   def authorize_user
     unless @current_user && @current_user.admin?
       render json: {error: "Not Authorized", status: 403}, status: 403
     end
   end
   #ensure a user is authorized by checking that @current_user is set and that the current user is an admin.

   def malformed_request
     render json: {error: "The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications.", status: 400}, status: 400
   end
   #executed if a ParameterMissing exception is thrown by any actions in the API controllers.


   def not_found
     render json: {error: "Record not found", status: 404}, status: 404
   end
   #executed if a RecordNotFound exception is thrown by any action in the API controllers.
 end
