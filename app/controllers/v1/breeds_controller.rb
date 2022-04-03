class V1::BreedsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @breeds = Breed.all
  end
end
