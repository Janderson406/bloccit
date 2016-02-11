require 'rails_helper'

include SessionsHelper
#add SessionsHelper so that we can use the create_session(user) method later in the spec.

RSpec.describe PostsController, type: :controller do
    let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
    let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
    let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }

#### GUEST USER (un-signed-in) user
  context "guest user" do
        #show, which allow *guests* to view posts in Bloccit
       describe "GET show" do
         it "returns http success" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(response).to have_http_status(:success)
         end

         it "renders the #show view" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(response).to render_template :show
         end

         it "assigns my_post to @post" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(assigns(:post)).to eq(my_post)
         end
       end

       #We won't allow guests to access the create, new, edit, update, or destroy actions.
       #expect guests to be redirected if they attempt to create, update, or delete a post.
       describe "GET new" do
         it "returns http redirect" do
           get :new, topic_id: my_topic.id
           expect(response).to redirect_to(new_session_path)
         end
       end

       describe "POST create" do
         it "returns http redirect" do
           post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
           expect(response).to redirect_to(new_session_path)
         end
       end

       describe "GET edit" do
         it "returns http redirect" do
           get :edit, topic_id: my_topic.id, id: my_post.id
           expect(response).to redirect_to(new_session_path)
         end
       end

       describe "PUT update" do
         it "returns http redirect" do
           new_title = RandomData.random_sentence
           new_body = RandomData.random_paragraph

           put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
           expect(response).to redirect_to(new_session_path)
         end
       end

       describe "DELETE destroy" do
         it "returns http redirect" do
           delete :destroy, topic_id: my_topic.id, id: my_post.id
           expect(response).to have_http_status(:redirect)
         end
       end
  end

######## SIGNED-IN USER ########
 context "signed-in user" do
  before do
    create_session(my_user)
 end


    ###READING POST TESTS
     describe "GET show" do
         it "returns http success" do
           get :show, topic_id: my_topic.id, id: my_post.id #Posts routes will now include the topic_id of the parent topic
           expect(response).to have_http_status(:success)
         end


         it "renders the #show view" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(response).to render_template :show
         end
         #expect the response to return the show view using the render_template matcher.

         it "assigns my_post to @post" do
           get :show, topic_id: my_topic.id, id: my_post.id
           expect(assigns(:post)).to eq(my_post)
         end
         # expect the post to equal my_post because we call show with the id of my_post.
         # We are testing that the post returned to us is the post we asked for.
     end

      ##CREATING POSTS TESTS: NEW & CREATE
      #When *new* is invoked, a new and unsaved Post object is created.
      #When *create* is invoked, the newly created object is persisted to the database
     describe "GET new" do
          it "returns http success" do
            get :new, topic_id: my_topic.id
            expect(response).to have_http_status(:success)
          end

          it "renders the #new view" do
            get :new, topic_id: my_topic.id
            expect(response).to render_template :new
          end
          #we expect PostsController#new to render the posts new view

          it "instantiates @post" do
            get :new, topic_id: my_topic.id
            expect(assigns(:post)).not_to be_nil
          end
        end
        #we expect @post instance variable to be initialized by PostsController#new.
        #assigns gives us access to the @post variable, assigning it to :post.

        describe "POST create" do
          it "increases the number of Post by 1" do
            expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
          end


          it "assigns the new post to @post" do
            post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
            expect(assigns(:post)).to eq Post.last
          end

          it "redirects to the new post" do
            post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
            expect(response).to redirect_to [my_topic, Post.last]
          end
        end
        #because the route for the posts show view will also be updated to reflect nested posts,
        #instead of redirecting to Post.last, we redirect to [my_topic, Post.last].
        #Rails' router can take an array of objects and build a route to the show page of the
        #last object in the array, nesting it under the other objects in the array.

        ##EDIT POSTS
        describe "GET edit" do
            it "returns http success" do
              get :edit, topic_id: my_topic.id, id: my_post.id
              expect(response).to have_http_status(:success)
            end

            it "renders the #edit view" do
              get :edit, topic_id: my_topic.id, id: my_post.id
              expect(response).to render_template :edit
            end

            it "assigns post to be updated to @post" do
              get :edit, topic_id: my_topic.id, id: my_post.id

              post_instance = assigns(:post)

              expect(post_instance.id).to eq my_post.id
              expect(post_instance.title).to eq my_post.title
              expect(post_instance.body).to eq my_post.body
            end

          end

        describe "PUT update" do
         it "updates post with expected attributes" do
           new_title = RandomData.random_sentence
           new_body = RandomData.random_paragraph

           put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}

           updated_post = assigns(:post)
           expect(updated_post.id).to eq my_post.id
           expect(updated_post.title).to eq new_title
           expect(updated_post.body).to eq new_body
         end
         #^^ Test that @post was updated with the title and body passed to update.
         # We also test that @post's id was not changed.

         it "redirects to the updated post" do
           new_title = RandomData.random_sentence
           new_body = RandomData.random_paragraph

           put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
           expect(response).to redirect_to [my_topic, my_post]
         end

       end

      ##DELETE POSTS
      describe "DELETE destroy" do
           it "deletes the post" do
             delete :destroy, topic_id: my_topic.id, id: my_post.id
             count = Post.where({id: my_post.id}).size
             expect(count).to eq 0
           end


           it "redirects to topic show" do
             delete :destroy, topic_id: my_topic.id, id: my_post.id
             expect(response).to redirect_to my_topic
           end
           #we want to be redirected to the topics show view instead of the posts index view.
         end
   end
 end

 #describe "GET index" do
 #  it "returns http success" do
 #    get :index
 #    expect(response).to have_http_status(:success)
 #  end
 #

#^^^remove the index tests. Posts will no longer need an index view because they'll be displayed on the show view of their parent topic.
