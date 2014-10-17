namespace :deploy do
  desc 'Restart unicorn application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      "/etc/init.d/unicorn_#{fetch(:full_app_name)} start"
    end
  end


end
