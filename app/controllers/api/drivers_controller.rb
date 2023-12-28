class API::DriversController < API::BaseController
  before_action :set_driver, only: [:show, :update, :destroy]

  api :GET, '/drivers', 'Retrieve a list of drivers'
  param :first_name, String, desc: 'Filter by first name (optional)'
  param :last_name, String, desc: 'Filter by last name (optional)'
  param :page, String, desc: 'Page number for pagination (optional)'
  param :per_page, String, desc: 'Number of records per page (optional)'

  def index
    @drivers = Driver.all
    @drivers = sort_and_filter(@drivers, filter_columns: [:first_name, :last_name])
    @drivers = paginate_query(@drivers, params)

    render_paginated_response @drivers
  end

  api :GET, '/drivers/:id', 'Retrieve a specific driver by ID'
  param :id, :number, required: true, desc: 'ID of the driver to retrieve'

  def show
    render json: @driver
  end

  api :POST, '/drivers', 'Create a new driver'

  param :first_name, String, desc: 'First name of the driver'
  param :last_name, String, desc: 'Last name of the driver'
  param :birth_date, String, desc: 'Date of birth of the driver'
  param :email, String, desc: 'Email address of the driver'
  param :phone_number, String, allow_nil: true, desc: 'Phone number of the driver'
  param :address1, String, desc: 'Address line 1 of the driver'
  param :address2, String, allow_nil: true, desc: 'Address line 2 of the driver'
  param :city, String, desc: 'City of residence of the driver'
  param :state, String, desc: 'State or province of residence of the driver'
  param :postal_code, String, desc: 'Postal code of the driver'
  param :country, String, allow_nil: true, desc: 'Country of residence of the driver'
  param :license_number, String, desc: 'Driver\'s license number'
  param :license_class, String, allow_nil: true, desc: 'Driver\'s license class'

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      render json: @driver, status: :created
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/drivers/:id', 'Update an existing driver by ID'
  param :id, :number, required: true, desc: 'ID of the driver to update'

  param :first_name, String, desc: 'First name of the driver'
  param :last_name, String, desc: 'Last name of the driver'
  param :birth_date, String, desc: 'Date of birth of the driver'
  param :email, String, desc: 'Email address of the driver'
  param :phone_number, String, allow_nil: true, desc: 'Phone number of the driver'
  param :address1, String, desc: 'Address line 1 of the driver'
  param :address2, String, allow_nil: true, desc: 'Address line 2 of the driver'
  param :city, String, desc: 'City of residence of the driver'
  param :state, String, desc: 'State or province of residence of the driver'
  param :postal_code, String, desc: 'Postal code of the driver'
  param :country, String, allow_nil: true, desc: 'Country of residence of the driver'
  param :license_number, String, desc: 'Driver\'s license number'
  param :license_class, String, allow_nil: true, desc: 'Driver\'s license class'

  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/drivers/:id', 'Delete a driver by ID'
  param :id, :number, required: true, desc: 'ID of the driver to delete'

  def destroy
    @driver.destroy
  end

  private
  def set_driver
    @driver = Driver.find(params[:id])
  end

  def driver_params
    params.permit(:first_name, :last_name, :birth_date, :email, :phone_number, :address1, :address2, :city, :state, :postal_code, :country, :license_number, :license_class)
  end
end
