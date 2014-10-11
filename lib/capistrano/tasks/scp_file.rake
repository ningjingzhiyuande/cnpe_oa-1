namespace :deploy do
   task :scp_file do
    on roles(:app) do
      config_files = fetch(:cp_files)
      config_files.each do |file|
        path  = file.split("/")
        path.pop
        execute :mkdir, '-pv', File.join(shared_path,path.join("/"))
        upload!(file, File.join(shared_path,path.join("/"))+"/")
      end
     
    end
   end
end
