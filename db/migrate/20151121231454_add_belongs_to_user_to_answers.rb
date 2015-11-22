class AddBelongsToUserToAnswers < ActiveRecord::Migration
  def change
    add_belongs_to :answers,  :user
  end
end
