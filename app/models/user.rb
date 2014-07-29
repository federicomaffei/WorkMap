class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook, :google]

  has_attached_file :image, styles: { thumb: '300x300>' }, storage: :s3, s3_credentials: {
    bucket: 'workmap',
    access_key_id: Rails.application.secrets.s3_access_key,
    secret_access_key: Rails.application.secrets.s3_secret_key
  }
  
  has_attached_file :cv, styles: { thumb: ['300x300>', :jpg]}, storage: :s3, s3_credentials: {
    bucket: 'workmap',
    access_key_id: Rails.application.secrets.s3_access_key,
    secret_access_key: Rails.application.secrets.s3_secret_key
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, presence: true, length: { minimum: 3}
  validates :cv, presence: true
  # validates_attachment_content_type :cv, :content_type => /.pdf\Z/

  after_create :send_user_welcome_email

def send_user_welcome_email
    UserWelcomeMailer.user_welcome(self).deliver
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        url = auth.info.image
        user.image = url.gsub('http:', "https:") # assuming the user model has an image
      end
    end
  end 