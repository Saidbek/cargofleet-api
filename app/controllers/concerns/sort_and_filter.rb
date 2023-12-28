# app/models/concerns/sort_and_filter.rb
module SortAndFilter
  extend ActiveSupport::Concern

  included do
    # helper_method :sort_column, :sort_direction
  end

  def sort_column
    # Define a default sort column if one isn't provided
    model_class.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    # Define a default sort direction if one isn't provided
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def filter
    # Define a default filter if one isn't provided
    params[:filter] || ''
  end

  def model_class
    # Return the class for the model being sorted and filtered
    controller_name.classify.constantize
  end

  def sort_and_filter(records, filter_columns: [])
    filter_keys = filter_columns.join(' LIKE ? OR ').concat(' LIKE ?')
    filter_values = filter_columns.length.times.map { "%#{filter}%" }

    # Sort and filter the records as specified in the request
    records.order("#{sort_column} #{sort_direction}").where(filter_keys, *filter_values)
  end
end
