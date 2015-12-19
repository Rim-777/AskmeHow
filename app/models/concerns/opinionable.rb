module Opinionable
  extend ActiveSupport::Concern
  included do
    has_many :opinions, as: :opinionable, dependent: :destroy

    def add_оpinion(value)

      opinion = opinions.where(user: current_user)
      if opinion.persisted?
        opinion.delete if  opinion.is_changed?(value)
      else
        opinion.create(vote: value)
      end

    end
  end
end