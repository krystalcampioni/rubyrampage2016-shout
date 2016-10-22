class AddShouterIdToShouts < ActiveRecord::Migration[5.0]
  def change
    add_column :shouts, :shouter_id, :integer
    add_index :shouts, :shouter_id
  end
end
