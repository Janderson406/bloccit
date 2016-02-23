class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy


   has_many :labelings, as: :labelable
   #relationship between Topic and Labeling, using the labeleable interface.
   has_many :labels, through: :labelings
   #define relationship between Topic to Label, using Labeling class through the labeleable *interface*.

end
