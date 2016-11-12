class Attachment < ActiveRecord::Base
  validates :file, presence: true
  belongs_to :attachable, polymorphic: true, touch: true
  mount_uploader :file, FileUploader

  default_scope { order(:created_at) }

  def file_name
    self.file.file.filename
  end
end
