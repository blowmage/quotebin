require "reserved/usernames"
require "email_validator"

class User < ActiveRecord::Base
  has_many :quotes, foreign_key: :owner_id
  has_many :taggings, class_name: "ActsAsTaggableOn::Tagging"
  has_many :tags, through: :taggings, class_name: "ActsAsTaggableOn::Tag"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username

  validates :email, presence: true, uniqueness: true, email: true
  validates :username, presence:   true,
                       uniqueness: true,
                       length:     { in: 3..32 },
                       format:     { with: /^[a-z0-9_]+$/i,
                                     message: "can only have letters, numbers and '_'" },
                       exclusion:  { in: Reserved::USERNAMES,
                                     message: "is reserved" }
  validates :name,     presence:   true

  def self.find_by_username nick
    where("username ILIKE ?", nick).first
  end
end
