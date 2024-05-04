class CreateCarousels < ActiveRecord::Migration[7.0]
  def change
    create_table :carousels do |t|
      t.string :type
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
