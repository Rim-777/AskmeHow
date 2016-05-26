module Reputationable
  extend ActiveSupport::Concern
  included do
    after_create :update_reputation

    private
    def update_reputation
      CalculateReputationJob.perform_later(self)
    end
  end
end
