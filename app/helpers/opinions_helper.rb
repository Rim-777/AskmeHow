module OpinionsHelper
  def  positive_opinion_path(opinionable)
    {controller: "opinions", action: "positive",
     opinionable_id: opinionable.id, opinionable_type: opinionable.class}
  end

  def  negative_opinion_path(opinionable)
    {controller: "opinions", action: "negative",
     opinionable_id: opinionable.id, opinionable_type: opinionable.class}
  end
end
