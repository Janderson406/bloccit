require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do
  let(:my_user) { create(:user) }

  context "authorized user" do

    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
      controller.authenticate_user
    end
    #set an HTTP header named HTTP_AUTHORIZATION in our request to the user's auth_token in order for our requests to work properly with the API.
    #Once the header is set, we call controller.authenticate_user which searches for a user in the database using the token that is passed in via the request header.

    describe "#authenticate_user" do
      it "finds a user by their authentication token" do
        expect(assigns(:current_user)).to eq(my_user)
      end
    end
    #authenticate_user finds the user by the specified token and sets current_user which then authenticates the user with the API.
  end

end
