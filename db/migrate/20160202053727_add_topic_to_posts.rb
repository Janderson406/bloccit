class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer
        #adds a topic_id column to the posts table.
    add_index :posts, :topic_id
        #index improves the speed of operations on a database table.
  end
end


#generated using:  $ rails generate migration AddTopicToPosts topic_id:integer:index
# "Add" + [table whose id we want to add] + "To" + [table we want to add the foreign key to]
# created a migration that adds a topic_id column to the posts table.
#
