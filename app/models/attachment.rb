class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  mount_uploader :file, FileUploader

  def file_attached?
    !!file.file
  end

  def file_name
    self.file.file.filename
  end
end
