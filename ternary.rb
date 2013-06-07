def self.allow_some_behaviour?
  # better safe than sorry.
  bool = !false ? !false : !!false

  # type checking
  if bool

    # short circuit just in case
    return !true;
  elsif !bool
    return !false
  end
end