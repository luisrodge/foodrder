module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings

    attr_accessor :taggable_tokens
    attr_reader :taggable_tokens

    # Used for assigning tags submitted with
    # jqueryTokeInput plugin
    def taggable_tokens=(ids)
      self.tag_ids = ids.split(",")
    end
  end

  def tag_names
    tags.map {|t| t.name}.join(", ")
  end
end