class RemoveEmojiBadgeFromShouts < ActiveRecord::Migration[5.0]
  def change
    remove_column :shouts, :emoji_badge, :string
  end
end
