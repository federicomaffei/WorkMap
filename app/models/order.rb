class Order < ActiveRecord::Base

  belongs_to :employer
  belongs_to :job
  # after_create :send_confirmation_email

end
