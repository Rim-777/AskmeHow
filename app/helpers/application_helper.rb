module ApplicationHelper

  def collection_cache_key_for(model)
    klass = model.to_s.capitalize.constantize
    count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:to_s)
    "#{model.to_s.pluralize}/collection-#{count}-#{max_updated_at}-when-user-#{current_user ? current_user.id: 'no_user'}"
  end

  # def object_cache_key_for(model)
  #   klass = model.to_s.capitalize.constantize
  #   count = klass.count
  #   max_updated_at = klass.maximum(:updated_at).try(:to_s)
  #   "#{model.to_s}/-#{}/-when-user-#{current_user ? current_user.id: 'no_user'}"
  # end

end
