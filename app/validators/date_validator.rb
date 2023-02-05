class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value && value < Date.today
      record.errors[attribute] << (options[:message] || "must be a future date")
    end
  end
end