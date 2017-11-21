module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings

    attr_accessor :taggable_tokens
    attr_reader :taggable_tokens
  end

  def tag_names
    tags.map(&:name)
  end
end