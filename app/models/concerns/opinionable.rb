module Opinionable
  extend ActiveSupport::Concern
  included do
    has_many :opinions, as: :opinionable, dependent: :destroy

    def type_and_id
      "#{self.class.to_s.downcase}_#{self.id}"
    end

  end
end