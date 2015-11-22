class AddBelongsToUserToQuestions < ActiveRecord::Migration
  def change
    add_belongs_to :questions, :user
  end
end
