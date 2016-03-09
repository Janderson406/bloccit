require 'rails_helper'
include RandomData
include SessionsHelper

 RSpec.describe VotesController, type: :controller do
   let(:my_topic) { create(:topic) }
   let(:my_user) { create(:user) }
   let(:other_user) { create(:user) }
   let(:my_post) { create(:post, topic: my_topic, user: my_user) }
   let(:my_vote) { Vote.create!(value: 1) }

  context "guest" do
    describe "POST up_vote" do
      it "redirects the user to the sign in view" do
        post :up_vote, format: :js, post_id: my_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      create_session(my_user)
      request.env["HTTP_REFERER"] = topic_post_path(my_topic, my_post)
    end

    describe "POST up_vote" do
      it "the users first vote increases number of post votes by one" do
        votes = my_post.votes.count
        post :up_vote, format: :js, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes + 1)
      end

      it "the users second vote does not increase the number of votes" do
        post :up_vote, format: :js, post_id: my_post.id
        votes = my_post.votes.count
        post :up_vote, format: :js, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes)
      end

      it "increases the sum of post votes by one" do
        points = my_post.points
        post :up_vote, format: :js, post_id: my_post.id
        expect(my_post.points).to eq(points + 1)
      end

      it "returns http success" do
        post :up_vote, format: :js, post_id: my_post.id
        expect(response).to have_http_status(:success)
      end

    end

    describe "POST down_vote" do
      it "the users first vote increases number of post votes by one" do
        votes = my_post.votes.count
        post :down_vote, format: :js, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes + 1)
      end

      it "the users second vote does not increase the number of votes" do
        post :down_vote, format: :js, post_id: my_post.id
        votes = my_post.votes.count
        post :down_vote, format: :js, post_id: my_post.id
        expect(my_post.votes.count).to eq(votes)
      end

      it "decreases the sum of post votes by one" do
        points = my_post.points
        post :down_vote, format: :js, post_id: my_post.id
        expect(my_post.points).to eq(points - 1)
      end

      it "returns http success" do
        post :down_vote, format: :js, post_id: my_post.id
        expect(response).to have_http_status(:success)
      end
    end
  end
end
