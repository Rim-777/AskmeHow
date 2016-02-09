class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user,  foreign_key: true
      t.belongs_to :question,  foreign_key: true

      t.timestamps null: false
    end
    add_index :subscriptions, [:user_id, :question_id], unique: true
  end
end
