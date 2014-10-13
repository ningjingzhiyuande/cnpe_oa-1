namespace :deploy do
  desc 'Restart unicorn application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
       sudo "/etc/init.d/unicorn_#{fetch(:full_app_name)} restart"
    end
  end

  desc 'generate kindeditor'
  task :generate_kindeditor do 
  	on roles(:app)  do
      # within fetch(:release_path) do
          with rails_env: fetch(:rails_env) do
            execute "cd #{release_path} && bundle exec rake kindeditor:assets"
          end
       # end
    end
  end

  desc 'link  sitemap'
  task :link_sitemap do 
  	on roles(:app)  do   
        execute "ln -nfs #{shared_path}/public/sitemap.xml.gz #{release_path}/public"       
    end
  end

  desc 'generate  sitemap'
  task :generate_sitemap do 
  	on roles(:app)  do   
        execute "cd #{release_path} && RAILS_ENV=production bundle exec rake chinababy:generate_sitemap"      
    end

  end

  desc 'link html to current'

  task :link_html do 
  	on roles(:app)  do   
        execute "ln -nfs #{shared_path}/public/html #{release_path}/public"       
    end
  end
 
end
