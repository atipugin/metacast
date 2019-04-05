namespace :factory_bot do
  task lint: :environment do
    if Rails.env.test?
      DatabaseCleaner.clean_with(:deletion)
      DatabaseCleaner.cleaning do
        FactoryBot.lint
      end
    else
      `RAILS_ENV=test bundle exec rake factory_bot:lint`
      raise if $?.exitstatus.nonzero?
    end
  end
end
