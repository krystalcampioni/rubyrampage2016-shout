class AddMessageToShouts < ActiveRecord::Migration[5.0]
  def change
    add_column :shouts, :message, :text
  end
end
