class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
   #relationship between Topic and Labeling, using the labeleable interface.
  has_many :labels, through: :labelings
   #define relationship between Topic to Label, using Labeling class through the labeleable *interface*.

   #scope :visible_to, -> { where(public: true) }
   # ^ This partially works, but it doesn't solve the problem of determining whether the topic is visible to a *particular user.*

   scope :visible_to, -> (user) { user ? all : Topic.publicly_viewable }
   #the ternary operator "?" keeps the lambda "->" on one line. This is essentially a one-line if / else condition.
   #It now returns the equivalent of topic_collection.all or topic_collection.where(public: true), depending on the value of user.

   scope :publicly_viewable, -> {where(public: true)}

   scope :privately_viewable, -> {where(public: false)}


end
