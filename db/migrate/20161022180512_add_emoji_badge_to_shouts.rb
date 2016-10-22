class AddEmojiBadgeToShouts < ActiveRecord::Migration[5.0]
  def change
    add_column :shouts, :emoji_badge, :string
  end
end
