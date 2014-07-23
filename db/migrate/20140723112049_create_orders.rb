class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :employer, index: true

      t.timestamps
    end
  end
end
