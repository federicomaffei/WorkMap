class Employer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  
  has_many :jobs
  has_many :orders

  # after_create :send_employer_welcome_email
  
  # def send_employer_welcome_email
  # 	EmployerWelcomeMailer.employer_welcome(self).deliver
  # end

end


