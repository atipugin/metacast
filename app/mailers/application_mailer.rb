class ApplicationMailer < ActionMailer::Base
  default from: 'Metacast <no-reply@metacast.xyz>'

  layout 'mailer'
end
