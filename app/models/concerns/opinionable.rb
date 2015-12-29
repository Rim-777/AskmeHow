module Opinionable
  extend ActiveSupport::Concern
  included do
    has_many :opinions, as: :opinionable, dependent: :destroy

    def type_and_id
      "#{self.class.to_s.downcase}_#{self.id}"
    end

    def type_of_entity
      "#{self.class.to_s.downcase}"
    end

  end
end