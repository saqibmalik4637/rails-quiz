class CreateUserInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :user_interests do |t|
      t.references :user
      t.references :interest

      t.timestamps
    end
  end
end
