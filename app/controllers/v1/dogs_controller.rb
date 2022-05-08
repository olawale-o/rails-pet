class V1::DogsController < ApplicationController
  load_and_authorize_resource param_method: :dog_params, except: %i[dogs]
  before_action :set_dog, only: %i[show update destroy]

  def dogs
    @dogs = Dog.all
  end

  def photos
    dog = Dog.find(params[:id])
    @dog_photos = dog.images
    render :photos, status: :ok
  end

  # GET /dogs
  def index
    if params[:breed_id]
      @breed_dogs = Breed.find(params[:breed_id]).dogs
    else
      @my_dogs = User.find(current_user.id).dogs
    end
  end

  # GET /dogs/1
  def show; end

  # POST /dogs
  def create
    @dog = Dog.new(dog_params)
    current_user.dogs << @dog
    if @dog.save
      render :show, status: :created
    else
      render json: @dog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dogs/1
  def update
    if @dog.update(dog_params)
      render :show, status: :created
    else
      render json: @dog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dogs/1
  def destroy
    @dog.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dog
    @dog = Dog.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dog_params
    params.require(:dog).permit(:name, :weight, :color, :gender, :breed_id, :description, images: [])
  end
end
