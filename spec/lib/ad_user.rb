class ADUser
  def initialize(first_name, last_name, email, groups)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @groups = groups
  end

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end

  def email
    @email
  end

  def user_groups
    @groups
  end
end