namespace :puma do
  task :start do
    on roles(:app) do
      execute 'sudo systemctl start metacast-puma.service'
    end
  end

  task :stop do
    on roles(:app) do
      execute 'sudo systemctl stop metacast-puma.service'
    end
  end

  task :reload do
    on roles(:app) do
      execute 'sudo systemctl reload-or-restart metacast-puma.service'
    end
  end

  task :restart do
    on roles(:app) do
      execute 'sudo systemctl restart metacast-puma.service'
    end
  end
end

after 'deploy:finished', 'puma:reload'
