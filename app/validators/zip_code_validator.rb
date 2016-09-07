class ZipCodeValidator< ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^\d{5}(-\d{4})?$/
      record.errors[attribute] <<
        (options[:message] || "is not a valid zip code")
    end
  end
end
