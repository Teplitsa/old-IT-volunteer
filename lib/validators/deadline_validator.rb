# encoding: utf-8

class DeadlineValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid') if value.nil? or (value < Time.now.beginning_of_day + 1.day)
  end

end