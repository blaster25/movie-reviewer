class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  
  has_many :movies
  has_many :reviews

  #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }

  def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
	    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
	    if conditions[:username].nil?
	      where(conditions).first
	    else
	      where(username: conditions[:username]).first
	    end
	  end
	end
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#", :thumb2 => "50x50>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_attachment :avatar, :presence => true
end
