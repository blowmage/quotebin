class Quote < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  acts_as_taggable
  acts_as_likeable

  attr_accessible :quotation, :author, :source, :url, :tag_list
end
