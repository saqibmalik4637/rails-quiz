class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :user
      t.references :quiz
      t.string :joining_code
      t.integer :status

      t.timestamps
    end
  end
end
