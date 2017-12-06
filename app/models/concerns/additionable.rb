module Additionable
  extend ActiveSupport::Concern

  included do
    has_many :additions, as: :additionable, validate: false, dependent: :destroy

    accepts_nested_attributes_for :additions
  end

end