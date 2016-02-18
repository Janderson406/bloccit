#created using $ rails generate model Comment body:text post:references
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
    #since comments belong to posts, we'll now be unable to create posts without a user
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }
 
     it { is_expected.to belong_to(:post) }
     it { is_expected.to belong_to(:user) }
     it { is_expected.to validate_presence_of(:body) }
     it { is_expected.to validate_length_of(:body).is_at_least(5) }

   describe "attributes" do
     it "should respond to body" do
       expect(comment).to respond_to(:body)
     end
   end

end
