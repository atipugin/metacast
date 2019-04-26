class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    Devise.mailer.reset_password_instructions(record, token)
  end

  private

  def record
    User.last
  end

  def token
    SecureRandom.hex
  end
end
