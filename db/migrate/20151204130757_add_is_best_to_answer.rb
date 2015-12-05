class AddIsBestToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :is_best, :boolean
  end
end
