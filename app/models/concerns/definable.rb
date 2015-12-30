module Definable
  extend ActiveSupport::Concern
  included do

    def type_and_id
      "#{self.class.to_s.downcase}_#{self.id}"
    end

    def entity
      "#{self.class.to_s.downcase}"
    end

  end
end