class CarouselItem < ApplicationRecord
  belongs_to :carousel
  belongs_to :collectable, polymorphic: true
end
