class Quote < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  attr_accessible :quotation, :author, :source, :url, :tag_list

  acts_as_taggable

end
