class Api::V1::CarouselsController < Api::V1::BaseController
  def index
    @carousels = Carousel.all.includes(carousel_items: :collectable)
  end
end
