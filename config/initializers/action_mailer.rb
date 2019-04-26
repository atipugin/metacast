config = Rails.application.config_for(:email).deep_symbolize_keys
Rails.application.config.action_mailer.default_url_options = config[:default_url_options]
Rails.application.config.action_mailer.delivery_method = config[:delivery_method].to_sym
Rails.application.config.action_mailer.smtp_settings = config[:smtp_settings]
