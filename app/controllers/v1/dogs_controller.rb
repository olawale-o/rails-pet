class V1::DogsController < ApplicationController
  ITEMS_PER_PAGE = 6
  START_INDEX = 0
  END_INDEX = 4
  load_and_authorize_resource param_method: :dog_params, except: %i[dogs]
  before_action :set_search, only: %i[dogs]
  before_action :set_dog, only: %i[show update destroy set_pet_photo]
  before_action :set_breed, unless: -> { params[:user_id] }, only: %i[index]
  before_action :set_user, unless: -> { params[:breed_id] }, only: %i[index]

  def dogs
    next_direction unless @direction == 'prev'
    prev_direction unless @direction == 'next'
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
    @dog.pic_url = photo_params[:url]
    @dog.save
    render :photos, status: :ok
  end

  # DELETE /dogs/1
  def destroy
    @dog.destroy
  end

  private

  def next_direction
    query_condition = @page ? ['id <= ?', @page] : nil
    all_dogs = Dog.where(query_condition).where(gender: @gender).order(id: :desc).limit(ITEMS_PER_PAGE)
    @dogs = all_dogs[START_INDEX..END_INDEX]
    @next_page_no = all_dogs[5].id if all_dogs[5]
    @prev_page_no = @dogs.first.id if @page
  end

  def prev_direction
    query_condition = @page ? ['id > ?', @page] : nil
    all_dogs = Dog.where(query_condition).where(gender: @gender).order(id: :asc).limit(ITEMS_PER_PAGE)
    @dogs = all_dogs[START_INDEX..END_INDEX].reverse
    @next_page_no = @page
    @prev_page_no = all_dogs[4].id if all_dogs[5]
  end

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

  def set_search
    # @breeds = Breed.all.pluck(:id)
    @page = params.fetch(:page).to_i if params[:page]&.to_i&.positive?
    @gender =
      if %w[m f].include? params.fetch(:gender)
        params.fetch(:gender)
      else
        %w[m f]
      end
    @direction = params.fetch(:direction)
    # @breed_id = @breeds unless @breeds.include? params.fetch(:breed)
  end
end
