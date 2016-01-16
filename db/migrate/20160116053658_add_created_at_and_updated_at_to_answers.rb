class AddCreatedAtAndUpdatedAtToAnswers < ActiveRecord::Migration
  def change

    add_column :answers, :created_at, :datetime, null: false
    add_column :answers, :updated_at, :datetime, null: false
  end
end
