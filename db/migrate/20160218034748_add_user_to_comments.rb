class AddUserToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
  end
end

#created using $ rails generate migration AddUserToComments user_id:integer:index
