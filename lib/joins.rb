module Joins
  def addee
    self.class_name.split("_").first
  end
end
