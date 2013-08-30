class CreateEditorials < ActiveRecord::Migration
  def change
    create_table :editorials do |t|
      t.string :name

      t.timestamps
      t.index(:name, :unique => true)
    end
  end
end
