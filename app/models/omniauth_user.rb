class OmniauthUser
  def initialize(auth)
    @auth = auth
  end

  def attributes
    { email: email }
  end

  def email
    @auth.info.email
  end

  def confirmed?
    auth.info.email?
  end
end
