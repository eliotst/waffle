class LabelValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless !value.nil? and
            !value.empty? and
            value.length < 30 and
            value =~ /\A[a-zA-Z0-9_]+\z/
      record.errors[attribute] << (options[:message] || "is not a label")
    end
  end
end
