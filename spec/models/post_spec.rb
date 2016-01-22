require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {Post.create!(title: "New Post Title", body: "New Post Body") }
  #we create a new instance of the Post class, and name it post.
  #The let method makes the Post instance available throughout the rest of the spec, so we only need to instantiate it once.
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
