namespace :deploy do
  task :setup_config do
    on roles(:app) do
      symlinks = fetch(:symlinks)
      symlinks.each do |symlink|
       sudo  "ln -nfs #{release_path}/#{symlink[:source]} #{symlink[:link]}"
      end
    end
  end
end
