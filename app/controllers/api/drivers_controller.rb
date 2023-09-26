class API::DriversController < API::BaseController
  before_action :set_driver, only: [:show, :update, :destroy]

  # API Endpoint: /api/drivers
  api :GET, '/drivers', 'Retrieve a list of drivers'
  param :first_name, String, desc: 'Filter by first name (optional)'
  param :last_name, String, desc: 'Filter by last name (optional)'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  # Description: This endpoint retrieves a paginated list of drivers, optionally filtered by first name and last name.
  def index
    @drivers = Driver.includes(:vehicle)
    @drivers = sort_and_filter(@drivers, filter_columns: [:first_name, :last_name])
    @drivers = paginate_query(@drivers, params)

    # Response:
    #   - Content-Type: application/json
    #   - Body: JSON array containing a list of drivers
    render_paginated_response @drivers
  end

  # API Endpoint: /api/drivers/:id
  api :GET, '/drivers/:id', 'Retrieve a specific driver by ID'
  param :id, :number, required: true, desc: 'ID of the driver to retrieve'

  # Description: This endpoint retrieves a specific driver by ID.
  def show
    render json: @driver
  end

  # API Endpoint: /api/drivers
  api :POST, '/drivers', 'Create a new driver'

  # Params for driver creation
  param :first_name, String, desc: 'First name of the driver', required: true
  param :last_name, String, desc: 'Last name of the driver', required: true
  param :birth_date, String, desc: 'Date of birth of the driver', required: true
  param :email, String, desc: 'Email address of the driver'
  param :phone_number, String, desc: 'Phone number of the driver'
  param :address1, String, desc: 'Address line 1 of the driver'
  param :address2, String, desc: 'Address line 2 of the driver'
  param :city, String, desc: 'City of residence of the driver'
  param :state, String, desc: 'State or province of residence of the driver'
  param :postal_code, String, desc: 'Postal code of the driver'
  param :country, String, desc: 'Country of residence of the driver'
  param :license_number, String, desc: 'Driver\'s license number'
  param :license_class, String, desc: 'Driver\'s license class'
  param :license_state, String, desc: 'State or province of driver\'s license issuance'
  param :active, [true, false], desc: 'Indicates whether the driver is active'

  # Description: This endpoint creates a new driver.
  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object representing the created driver
      render json: @driver, status: :created
    else
      # Response:
      #   - Content-Type: application/json
      #   - Body: JSON object containing validation errors
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # API Endpoint: /api/drivers/:id
  api :PATCH, '/drivers/:id', 'Update an existing driver by ID'
  param :id, :number, required: true, desc: 'ID of the driver to update'

  # Params for driver update
  param :first_name, String, desc: 'First name of the driver'
  param :last_name, String, desc: 'Last name of the driver'
  param :birth_date, String, desc: 'Date of birth of the driver'
  param :email, String, desc: 'Email address of the driver'
  param :phone_number, String, desc: 'Phone number of the driver'
  param :address1, String, desc: 'Address line 1 of the driver'
  param :address2, String, desc: 'Address line 2 of the driver'
  param :city, String, desc: 'City of residence of the driver'
  param :state, String, desc: 'State or province of residence of the driver'
  param :postal_code, String, desc: 'Postal code of the driver'
  param :country, String, desc: 'Country of residence of the driver'
  param :license_number, String, desc: 'Driver\'s license number'
  param :license_class, String, desc: 'Driver\'s license class'
  param :license_state, String, desc: 'State or province of driver\'s license issuance'
  param :active, [true, false], desc: 'Indicates whether the driver is active'

  # Description: This endpoint updates an existing driver by ID.
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # API Endpoint: /api/drivers/:id
  api :DELETE, '/drivers/:id', 'Delete a driver by ID'
  param :id, :number, required: true, desc: 'ID of the driver to delete'

  # Description: This endpoint deletes a driver by ID.
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
    params.permit(:first_name, :last_name, :birth_date, :email, :phone_number, :address1, :address2, :city, :state, :postal_code, :country, :license_number, :license_class, :license_state, :active)
  end
end
