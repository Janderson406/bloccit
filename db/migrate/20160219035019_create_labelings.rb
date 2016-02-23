class CreateLabelings < ActiveRecord::Migration
  def change
    create_table :labelings do |t|
      t.references :label, index: true

       t.references :labelable, polymorphic: true, index: true
       t.timestamps null: false
       #create a column which will have the name labelable_id using t.references :labelable.
       #We also use polymorphic: true which adds a type column called labelable_type to associate a labeling with different objects.
     end
     add_foreign_key :labelings, :labels
    end
  
end
