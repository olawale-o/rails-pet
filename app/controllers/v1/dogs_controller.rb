class V1::DogsController < ApplicationController
  load_and_authorize_resource param_method: :dog_params, except: %i[dogs]
  before_action :set_dog, only: %i[show update destroy set_pet_photo]
  before_action :set_breed, unless: -> { params[:user_id] }, only: %i[index]
  before_action :set_user, unless: -> { params[:breed_id] }, only: %i[index]

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
      @breed_dogs = @breed.dogs
    else
      @my_dogs = User.find(params[:user_id]).dogs
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

  # POST /dogs/1
  def set_pet_photo
    @dog.pic_url = photo_params
    @dog.save
    render :photos, status: :ok
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

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_breed
    @breed = Breed.find(params[:breed_id])
  end

  # Only allow a trusted parameter "white list" through.
  def dog_params
    params.require(:dog).permit(:name, :weight, :color, :gender, :breed_id, :description, images: [])
  end

  def photo_params
    params.require(:photo).permit(:url)
  end
end
