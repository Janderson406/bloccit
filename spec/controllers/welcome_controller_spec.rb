require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET index" do
     it "renders the index template" do
       # call the index method of WelcomeController
       get :index

       expect(response).to render_template("index")
     end
   end

   describe "GET about" do
     it "renders the about template" do
       get :about

       expect(response).to render_template("about")
     end
   end

end
