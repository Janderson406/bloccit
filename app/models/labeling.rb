class Labeling < ActiveRecord::Base
   belongs_to :labelable, polymorphic: true
   belongs_to :label
 end

 #we stipulate that Labeling is polymorphic and that it can mutate into different types of objects through labelable
