namespace :sidekiq do
  task :start do
    on roles(:app) do
      execute 'sudo systemctl start metacast-sidekiq.service'
    end
  end

  task :stop do
    on roles(:app) do
      execute 'sudo systemctl stop metacast-sidekiq.service'
    end
  end

  task :restart do
    on roles(:app) do
      execute 'sudo systemctl restart metacast-sidekiq.service'
    end
  end
end

after 'deploy:finished', 'sidekiq:restart'
