class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :author_id
      t.integer :editorial_id
      t.date :published_date
      t.string :format

      t.timestamps
    end
  end
end
