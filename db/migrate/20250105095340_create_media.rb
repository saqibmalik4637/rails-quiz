class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.string :name
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
