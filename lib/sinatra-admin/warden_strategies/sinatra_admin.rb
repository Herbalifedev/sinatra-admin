Warden::Strategies.add(:sinatra_admin) do
  def valid?
    email && password
  end

  def authenticate!
    admin = SinatraAdmin.config.admin_model.find_by(email: email)

    if admin.nil?
      fail!("The email you entered does not exist.")
    elsif admin.authenticate(password)
      success!(admin)
    else
      fail!("You entered an incorrect password")
    end
  end

  private

  def email
    params['data']['email']
  end

  def password
    params['data']['password']
  end
end
