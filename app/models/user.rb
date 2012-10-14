require "reserved/usernames"
require "email_validator"

class User < ActiveRecord::Base
  has_many :quotes, foreign_key: :owner_id
  has_many :taggings, class_name: "ActsAsTaggableOn::Tagging"
  has_many :tags, through: :taggings, class_name: "ActsAsTaggableOn::Tag"
  has_many :streams

  acts_as_followable
  acts_as_follower
  acts_as_liker

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

  # TODO: Refine this list to get the most useful quotes
  def quote_bag
    QuoteBag.new quotes
  end

  # TODO: Refine this list to get the most useful tags
  def tag_recommendations(n=3)
    quote_bag.tag_recommendations(Quote.all, n)
  end
end
