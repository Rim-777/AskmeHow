class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :opinionable
      t.string :opinionable_type
      t.integer :value
      t.index [:opinionable_id, :opinionable_type]
      t.timestamps null: false
    end
  end
end
