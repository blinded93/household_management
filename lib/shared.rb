module Shared
  def class_name
    self.class.name.downcase
  end

  def id_name(field)
    class_name + "_" + field.to_s
  end
end
