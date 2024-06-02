class CreateRoomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :room_users do |t|
      t.references :user
      t.references :room
      t.datetime :joined_at
      t.integer :status

      t.timestamps
    end
  end
end
