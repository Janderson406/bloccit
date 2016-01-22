class Post < ActiveRecord::Base #handles interaction with database/allows us to persist data through our class
  has_many :comments
end
