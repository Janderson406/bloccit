require 'rails_helper'

 RSpec.describe Api::V1::UsersController, type: :controller do
   let(:my_user) { create(:user) }

 #we verify that the index and show views return a 401 if the request is unauthenticated
   context "unauthenticated users" do
     it "GET index returns http unauthenticated" do
       get :index
       expect(response).to have_http_status(401)
     end

     it "GET show returns http unauthenticated" do
       get :show, id: my_user.id
       expect(response).to have_http_status(401)
     end
   end

 # test that an HTTP response code 403 is returned for unauthenticated and unauthorized users.
   context "authenticated and unauthorized users" do
     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end

     it "GET index returns http forbidden" do
       get :index
       expect(response).to have_http_status(403)
     end

     it "GET show returns http forbidden" do
       get :show, id: my_user.id
       expect(response).to have_http_status(403)
     end
   end

 #test the behavior for an authenticated and authorized user.
   context "authenticated and authorized users" do
     before do
       my_user.admin!
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end

     describe "GET index" do
       before { get :index }

       it "returns http success" do
         expect(response).to have_http_status(:success)
       end

 #test that the response.content_type is application/json. Content type in the response is a header and is added by the Bloccit API.
       it "returns json content type" do
         expect(response.content_type).to eq("application/json")
       end

       it "returns my_user serialized" do
         expect(response.body).to eq([my_user].to_json)
       end
     end

 #test the show view for an authenticated and authorized user.
     describe "GET show" do
       before { get :show, id: my_user.id }

       it "returns http success" do
         expect(response).to have_http_status(:success)
       end

       it "returns json content type" do
         expect(response.content_type).to eq 'application/json'
       end

       it "returns my_user serialized" do
         expect(response.body).to eq(my_user.to_json)
       end
     end
   end
 end
