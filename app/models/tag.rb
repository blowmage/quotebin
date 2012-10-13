require "acts_as_taggable_on/tag"

Tag = ActsAsTaggableOn::Tag

class Tag
  acts_as_followable

  def self.find_by_name name
    named(name).first
  end
end
