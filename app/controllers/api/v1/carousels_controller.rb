class Api::V1::CarouselsController < Api::V1::BaseController
  def index
    @carousels = Carousel.order(position: :asc)
  end
end
