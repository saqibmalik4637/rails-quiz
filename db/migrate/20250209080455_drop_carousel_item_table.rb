class DropCarouselItemTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :carousel_items
  end

  def down
    create_table :carousel_items do |t|
      t.references :collectable, polymorphic: true
      t.references :carousel
      t.boolean :show_on_homepage, default: false

      t.timestamps
    end
  end
end
