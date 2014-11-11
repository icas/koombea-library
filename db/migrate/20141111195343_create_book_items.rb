class CreateBookItems < ActiveRecord::Migration
  def change
    create_table :book_items do |t|
      t.string :format
      t.integer :user_id
      t.integer :book_id
      t.timestamps
    end
  end
end
