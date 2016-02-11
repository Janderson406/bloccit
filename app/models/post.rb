class Post < ActiveRecord::Base #handles interaction with database/allows us to persist data through our class
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order('created_at DESC') }
  #The default_scope will order all posts by their created_at date, in descending order,
  #The most recent posts will be displayed first on topic show views

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
#Comments are dependent on a post's existence because of the has_many :comments declaration in Post.
#When we delete a post, we also need to delete all related comments.
#perform a "cascade delete" => ensures that when a post is deleted, all of its comments are too.


#test validation   n = Post.new :title => "A Very Long Title", :body => "this is the body. where these characters live", :topic => "validations"
