module Opinionable
  extend ActiveSupport::Concern
  include Definable
  included do
    has_many :opinions, as: :opinionable, dependent: :destroy
  end
end