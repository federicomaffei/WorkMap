class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :message
      t.text :cv
      t.belongs_to :user
      t.belongs_to :job

      t.timestamps
    end
  end
end
