class AddJobsToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :job, index: true
  end
end
