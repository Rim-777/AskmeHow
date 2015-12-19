module Opinionable
  extend ActiveSupport::Concern
  included do
    has_many :opinions, as: :opinionable, dependent: :destroy

    # def say_оpinion(value)
    #
    #   opinion = self.opinions.where(user: current_user).first
    #   if opinion.persisted?
    #     opinion.delete if opinion.is_changed?(value)
    #   else
    #     opinion.create(value: value)
    #   end
    #
    # end
  end
end