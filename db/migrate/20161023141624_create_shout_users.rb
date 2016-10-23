class CreateShoutUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :shout_users do |t|
      t.references :user, foreign_key: true
      t.references :shout, foreign_key: true

      t.timestamps
    end
  end
end
