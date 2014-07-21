class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :category
      t.string :company
      t.boolean :full_time
      t.text :detail
      t.string :location
      t.integer :pay

      t.timestamps
    end
  end
end
