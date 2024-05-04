class CategoryCarousel < Carousel
  has_many :categories, through: :carousel_items, source_type: 'Category', source: :collectable

  def homepage_items
    categories.joins(:carousel_items).where(carousel_items: { show_on_homepage: true }).distinct
  end
end
