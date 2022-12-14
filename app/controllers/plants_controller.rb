class PlantsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :error_response

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update
    plant = Plant.find(params[:id])
    plant.update(plant_params)
    render json: plant, response: :created
  end

  def destroy
    Plant.find(params[:id]).destroy
    head :no_content
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def error_response
    render json: { error: "plant not found" }, response: :not_found
  end

end
