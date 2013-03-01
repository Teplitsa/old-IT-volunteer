# encoding: utf-8

class WebsiteValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
  	if value.present? && !(value =~ /(^(http|https):\/\/[а-яёa-z0-9]+([\-\.]{1}[а-яёa-z0-9]+)*\.[а-яёa-z]{2,5}(:[0-9]{1,5})?(\/.*)?$)|(^[а-яёa-z0-9]+([\-\.]{1}[а-яёa-z0-9]+)*\.[а-яёa-z]{2,5}$)/ix )
	    record.errors[attribute] << (options[:message] || 'имеет неправильный формат')
	  end
  end

end