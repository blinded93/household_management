module Joins
  def attrs
    attributes.keys.select do |attr|
      !attr.include?("_") && !attr.include?("id")
    end
  end

  def addee
    self.class_name.split("_").first
  end
end
