class AddKarmaWeight < ActiveRecord::Migration
  def change
    add_column :topics, :karma, :integer, default: 0
    add_index :topics, :karma
  end
end
