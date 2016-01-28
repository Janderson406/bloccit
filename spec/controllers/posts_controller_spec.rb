require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  #create a post and assign it to my_post using let.
  #use RandomData to give my_post a random title and body.
  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index
#test created a post (my_post), expect index to return an array of one item.
#use assigns, a method in ActionController::TestCase. assigns gives the test access
#to "instance variables assigned in the action that are available for the view".
      expect(assigns(:posts)).to eq([my_post])
    end
  end

###READING POST TESTS
 describe "GET show" do
     it "returns http success" do
       get :show, {id: my_post.id}
       expect(response).to have_http_status(:success)
     end
       #pass {id: my_post.id} to show as a parameter. These parameters are passed to the params hash.
       #The params hash contains all parameters passed to the application's controller
       #(application_controller.rb), whether from GET, POST, or any other HTTP action.

     it "renders the #show view" do
       get :show, {id: my_post.id}
       expect(response).to render_template :show
     end
     #expect the response to return the show view using the render_template matcher.

     it "assigns my_post to @post" do
       get :show, {id: my_post.id}
       expect(assigns(:post)).to eq(my_post)
     end
     # expect the post to equal my_post because we call show with the id of my_post.
     # We are testing that the post returned to us is the post we asked for.
 end

###CREATING POSTS TESTS: NEW & CREATE
  #When *new* is invoked, a new and unsaved Post object is created.
  #When *create* is invoked, the newly created object is persisted to the database
 describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end
      #we expect PostsController#new to render the posts new view

      it "instantiates @post" do
        get :new
        expect(assigns(:post)).not_to be_nil
      end
    end
    #we expect @post instance variable to be initialized by PostsController#new.
    #assigns gives us access to the @post variable, assigning it to :post.

    describe "POST create" do
      it "increases the number of Post by 1" do
        expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
      end
      #after PostsController#create is called, Post instances (i.e. rows in the posts table) in the database will increase

      it "assigns the new post to @post" do
        post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:post)).to eq Post.last
      end

      it "redirects to the new post" do
        post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to Post.last
      end
    end
    #we expect to be redirected to the newly created post.

 #  describe "GET edit" do
 #    it "returns http success" do
 #      get :edit
 #      expect(response).to have_http_status(:success)
 #    end
 #  end

 end
