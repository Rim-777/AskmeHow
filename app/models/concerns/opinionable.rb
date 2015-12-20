module Opinionable
  extend ActiveSupport::Concern
  included do
    has_many :opinions, as: :opinionable, dependent: :destroy
  end
end