class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :image, styles: { thumb: '300x300>' }, s3_credentials: {
      bucket: 'workmap',
      access_key_id: Rails.application.secrets.s3_access_key,
      secret_access_key: Rails.application.secrets.s3_secret_key
    }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
	