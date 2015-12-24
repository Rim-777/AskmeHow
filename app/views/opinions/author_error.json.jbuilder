json.error_message "You can't vote for your #{@opinionable.class.to_s.downcase}"
json.id @opinionable.id
json.opinionable_class @opinionable.class.to_s.downcase
