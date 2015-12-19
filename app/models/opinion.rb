class Opinion < ActiveRecord::Base

  belongs_to :user
  belongs_to :opinionable, polymorphic: true
  validates :value, presence: true

 def is_changed?(value)
   self.value != value
 end

end