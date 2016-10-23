class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.string :emoji
      t.references :shout, foreign_key: true
      t.string :user_identifier
      t.integer :counter, default: 0

      t.timestamps
    end
  end
end
