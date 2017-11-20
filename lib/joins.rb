module Joins
  def attrs
    attributes.keys.select do |attr|
      !attr.include?("_") && !attr.include?("id")
    end
  end
end
