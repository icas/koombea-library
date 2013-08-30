class CreateBookExemplaries < ActiveRecord::Migration
  def change
    create_table :book_exemplaries do |t|
      t.belongs_to :book
      t.belongs_to :owner
      t.boolean :available, default: true

      t.timestamps
      t.index(:book_id)
      t.index(:owner_id)
    end
  end
end
