class CreatePosts < ActiveRecord::Migration
  def change #When we run the migration, the change method calls the create_table method.
    create_table :posts do |t|
      #create_table takes a block that specifies the attributes we want our table to possess.
      t.string :title
      t.text :body

      t.timestamps null: false
      #Rails automatically adds timestamp attributes named created_at and updated_at to the migration.
    end
  end
end
