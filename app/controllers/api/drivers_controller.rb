class API::DriversController < API::BaseController
  before_action :set_driver, only: [:show, :update, :destroy]

  # GET /drivers
  def index
    @drivers = paginate_query(Driver.order(:id), params)

    render_paginated_response @drivers
  end

  # GET /drivers/1
  def show
    render json: @driver
  end

  # POST /drivers
  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      render json: @driver, status: :created
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drivers/1
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drivers/1
  def destroy
    @driver.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_params
      params.require(:driver).permit(:first_name, :last_name, :birth_date, :email, :phone_number, :address1, :address2, :city, :state, :postal_code, :country, :license_number, :license_class, :license_state)
    end
end
