class CreateEditorials < ActiveRecord::Migration
  def change
    create_table :editorials do |t|
      t.string :name

      t.timestamps
    end
  end
end
