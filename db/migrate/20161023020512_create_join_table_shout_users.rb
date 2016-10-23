class CreateJoinTableShoutUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :shouts, :users
  end
end
