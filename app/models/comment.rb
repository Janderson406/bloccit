#created using $ rails generate model Comment body:text post:references
class Comment < ActiveRecord::Base
  belongs_to :post #comment belongs to a post / a post has many comments.
end
