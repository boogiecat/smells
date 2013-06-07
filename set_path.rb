def set_path
  if name && (!path || path == "/")
    self.path = self.parent.present? ? "#{self.parent.path}/#{name}" : "/#{name}"
  elsif !new_record? && name && path && name_was != name
    parts = path.split("/")
    parts.pop
    self.path = [parts.join("/"), name].join("/")
  elsif !new_record? && name && self.parent_id_changed?
    self.path = self.parent.present? ? "#{self.parent.path}/#{name}" : "/#{name}"
  elsif new_record? && name && path
    self.path = [path, name].join("/")
  end

  if path && self.parent.blank?
    parts = path.split("/")

    self.name = parts.pop

    parent_path = parts.join("/")
    if parent_path.blank? || parent_path == "/"
      self.parent = nil
    else
      possible_parent = site.asset_folders.find_by_path(parent_path)
      self.parent = possible_parent.present? ? possible_parent : self.class.create(path: parent_path, site: site)
    end
  end
  true
end