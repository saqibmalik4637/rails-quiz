class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :lastname
      t.string :email
      t.string :password
      t.string :type
      t.integer :age

      t.timestamps
    end
  end
end
