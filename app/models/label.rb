class Label < ActiveRecord::Base

  has_many :labelings
   #associate label with many labelings.
     has_many :topics, through: :labelings, source: :labelable, source_type: :Topic
     #has many topics through the labelings table
     has_many :posts, through: :labelings, source: :labelable, source_type: :Post
     #label has many posts through the labelings table.

     def self.update_labels(label_string)

       return Label.none if label_string.blank?
       #return if the label_string passed in is blank

 # #25
      label_string.split(",").map do |label|
        Label.find_or_create_by(name: label.strip)
      end
    end
    #update_labels splits up label_string which is how we are storing our labels on the backend
    #by splitting the string on a comma. For each label, we call find_or_create using the label name.
    #This ensures that we never create a duplicate label.


end
