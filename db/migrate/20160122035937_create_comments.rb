#created with $ rails generate model Comment body:text post:references

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      #Symbol^ represents the table name; block arg. contains the details to be added to the table
      t.text :body
      t.references :post, index: true, foreign_key: true
      #index tells the db to index the post_id column, so it can be searched efficiently.
      #added automatically when you generate with the 'references' argument.
      t.timestamps null: false
    end
  end
end
