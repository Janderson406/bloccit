require 'rails_helper'

 RSpec.describe Label, type: :model do
   let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
   let(:label) { Label.create!(name: 'Label') }
   let(:label2) { Label.create!(name: 'Label2') }

 # label should have_many labelings (could be either a topic or a post) => our polymorphic relationships.
   it { is_expected.to have_many :labelings }

   it { is_expected.to have_many(:topics).through(:labelings) }
   it { is_expected.to have_many(:posts).through(:labelings) }

   describe "labelings" do
     it "allows the same label to be associated with a different topic and post" do
       topic.labels << label
       post.labels << label

       topic_label = topic.labels[0]
       post_label = post.labels[0]

       expect(topic_label).to eql(post_label)
       #expect that the label associated with post and topic is the same
     end
   end

   #using a . to describe update_labels because update_labels is a class method.
   #update_labels is a class method because it affects more than one Label at a time,
   #thus it does not make sense to make it an instance method.
    describe ".update_labels" do
      it "takes a comma delimited string and returns an array of Labels" do
        labels = "#{label.name}, #{label2.name}"
        labels_as_a = [label, label2]

        expect(Label.update_labels(labels)).to eq(labels_as_a)
        #we expect update_labels to return an array of label objects which are parsed from the comma-delimited string that is passed in.
      end
    end

end
