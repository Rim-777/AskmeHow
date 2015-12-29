class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :user, index:true
      t.belongs_to :commentable
      t.string :commentable_type
      t.index [:commentable_id, :commentable_type]
      t.timestamps null: false
    end
  end
end
