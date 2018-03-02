module Shared
  def class_name
    a ||= self.class.name.split(/(?=[A-Z])/)
    a.join("_").downcase
  end

  def plural_name
    class_name.pluralize
  end

  def id_name(field)
    a = [class_name, "_"]
    if field == :item_id
      a << "item_attributes_name"
    else
      a << field.to_s
    end
    if persisted?
      a.insert(2, self.id.to_s + "_")
    end
    a.join.html_safe
  end

  def error_div
    a = [class_name, "_", "errors"]
    if persisted?
      a.insert(2, self.id.to_s + "_")
    end
    a.join.html_safe
  end

  def tbody_id(scope)
    [plural_name, "_", scope.to_s, "_tbody"].join.html_safe
  end

  def row_id
    [class_name, "_", id.to_s].join.html_safe
  end

  def row_partial
    [class_name, "s/", class_name].join.html_safe
  end

  def completed_fields
    cols - errors.keys
  end

  def reload_div(scope)
    [scope.to_s, "_", plural_name, "_collapse"].join.html_safe
  end

  def scope_table(scope)
    [plural_name, "_", scope.to_s, "_tbody"].join.html_safe
  end

  def badge_span(scope)
    [scope.to_s, "_", plural_name, "_badge"].join.html_safe
  end
end
