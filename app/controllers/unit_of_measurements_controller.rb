class UnitOfMeasurementsController < ApplicationController
  before_action :set_unit_of_measurement, only: %i[ show edit update destroy ]

  def index
    @unit_of_measurements = UnitOfMeasurement.all
  end

  def show
  end

  def new
    @unit_of_measurement = UnitOfMeasurement.new
  end

  def edit
  end

  def create
    @unit_of_measurement = UnitOfMeasurement.new(unit_of_measurement_params)

    respond_to do |format|
      if @unit_of_measurement.save
        format.html { redirect_to @unit_of_measurement, notice: "unit_of_measurement was successfully created." }
        format.json { render :show, status: :created, location: @unit_of_measurement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit_of_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @unit_of_measurement.update(unit_of_measurement_params)
        format.html { redirect_to @unit_of_measurement, notice: "unit_of_measurement was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @unit_of_measurement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit_of_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @unit_of_measurement.destroy!

    respond_to do |format|
      format.html { redirect_to unit_of_measurements_path, notice: "unit_of_measurement was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_of_measurement
      @unit_of_measurement = UnitOfMeasurement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def unit_of_measurement_params
      params.require(:unit_of_measurement).permit(:name, :quantity, :sku)
    end
end
