class AddPaidToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :paid, :boolean
  end
end
