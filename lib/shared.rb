module Shared
  def class_name
    a = self.class.name.split(/(?=[A-Z])/)
    a.join("_").downcase
  end

  def plural_name
    class_name.pluralize
  end

  def form_input_id(field)
    a = [class_name, "_"]
    a.push(field == :item_id ? "item_attributes_name" : field.to_s)
    a.join.html_safe
  end

  def error_div_id
    a = [class_name, "_", "errors"]
    a.join.html_safe
  end

  def row_id
    [class_name, "_", id.to_s].join.html_safe
  end

  def completed_fields
    cols - errors.keys
  end

  def badge_span(scope)
    [scope.to_s, "_", plural_name, "_badge"].join.html_safe
  end
end
