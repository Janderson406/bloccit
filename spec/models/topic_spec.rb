require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }
  # ^ changed all of our model specs to use our new factories

  it { is_expected.to have_many(:posts) }

  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }

   describe "attributes" do
     it "responds to name" do
       expect(topic).to respond_to(:name)
     end

     it "responds to description" do
       expect(topic).to respond_to(:description)
     end

     it "responds to public" do
       expect(topic).to respond_to(:public)
     end
     #confirm that the public attribute is set to true by default
     it "is public by default" do
       expect(topic.public).to be(true)
     end
   end

   describe "scopes" do
     before do
       #create public and private topics to use for testing scopes
       @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
       @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
     end

     describe "visible_to(user)" do
       it "returns all topics if the user is present" do
         user = User.new
         #expect the visible_to scope to return all topics if the user is present.
         expect(Topic.visible_to(user)).to eq(Topic.all)
       end

       it "returns only public topics if user is nil" do
         #expect the visible_to scope to return public topics if the user isn't present.
         expect(Topic.visible_to(nil)).to eq([@public_topic])
       end
     end
   end



end
