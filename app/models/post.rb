class Post < ActiveRecord::Base #handles interaction with database/allows us to persist data through our class
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
    # ^relates the models and allows us to call post.votes.
    #We also add dependent: :destroy to ensure that votes are destroyed when their parent post is deleted.
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  default_scope { order('rank DESC') } 

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  ### votes in the below code is an implied self.votes
  def up_votes
    #find the up votes for a post by passing value: 1 to where. This fetches a collection of votes with a value of 1.
    #We then call count on the collection to get a total of all up votes.
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    #use ActiveRecord's sum method to add the value of all the given post's votes.
    #Passing :value to sum tells it what attribute to sum in the collection
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end
end
#Comments are dependent on a post's existence because of the has_many :comments declaration in Post.
#When we delete a post, we also need to delete all related comments.
#perform a "cascade delete" => ensures that when a post is deleted, all of its comments are too.


#test validation   n = Post.new :title => "A Very Long Title", :body => "this is the body. where these characters live", :topic => "validations"
