class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:image
  
  # mount_uploader :image,ImageUploader

  validates :email, :email => {:mx => true, :message => I18n.t('validations.errors.models.user.invalid_email')}
  # attr_accessible :title, :body

  has_many :comments
end
