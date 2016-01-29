class Post < ActiveRecord::Base #handles interaction with database/allows us to persist data through our class
  has_many :comments, dependent: :destroy
end
#Comments are dependent on a post's existence because of the has_many :comments declaration in Post.
#When we delete a post, we also need to delete all related comments.
#perform a "cascade delete" => ensures that when a post is deleted, all of its comments are too.
