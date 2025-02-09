class AddClassificationToCarousels < ActiveRecord::Migration[7.0]
  def change
    add_column :carousels, :classification, :integer
  end
end
