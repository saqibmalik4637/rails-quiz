class AddPositionToCarousel < ActiveRecord::Migration[7.0]
  def change
    add_column :carousels, :position, :integer, default: 0, null: false
  end
end
