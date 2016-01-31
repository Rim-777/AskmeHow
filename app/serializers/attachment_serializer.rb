class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :file, :attachable_id, :attachable_type, :created_at, :updated_at

end
