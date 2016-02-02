require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  #we create a parent topic for post.
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  #we create a new instance of the Post class, and name it post.
  #The let method makes the Post instance available throughout the rest of the spec, so we only need to instantiate it once.
  it { is_expected.to belong_to(:topic) }
  #we associate post with topic via topic.posts.create!, chained method call which creates a post for a given topic.

  describe "attributes" do
     #we test whether post has an attribute named title. This tests whether post will return a non-nil value when post.title is called.
     it "should respond to title" do
       expect(post).to respond_to(:title)
     end
     it "should respond to body" do
       expect(post).to respond_to(:body)
     end
  end



end
