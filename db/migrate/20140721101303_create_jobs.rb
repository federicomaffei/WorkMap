class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :advert_title
      t.string :category
      t.string :company
      t.boolean :full_time
      t.text :detail
      t.string :address
      t.integer :wage

      t.timestamps
    end
  end
end
