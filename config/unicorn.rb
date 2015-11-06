root = "/home/yang/Sites/cnpe_oa"
working_directory root
pid "#{root}/tmp/pids/unicorn_cnpe_oa.pid"
stderr_path "#{root}/log/unicorn_cnpe_oa.stderr.log"
stdout_path "#{root}/log/unicorn_cnpe_oa.log"

listen "/tmp/unicorn_cnpe_oa.sock"
worker_processes 3
timeout 30
#preload_app true
