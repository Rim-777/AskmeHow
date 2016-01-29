class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  mount_uploader :file, FileUploader

  validates :file, presence: true
  # scope :ordered, -> { order('created_at') }
  default_scope { order(:created_at) }

  def file_name
    self.file.file.filename
  end
end
