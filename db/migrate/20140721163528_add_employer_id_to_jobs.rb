class AddEmployerIdToJobs < ActiveRecord::Migration
  def change
    add_reference :jobs, :employer, index: true
  end
end
