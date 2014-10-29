#!/bin/bash
 
# deploy.sh
 
# Put this script on your production server and make it executable with chmod
# +x. 
 
# Set the deploy_dir variable to the path on the production server to
# deployment directory. The script assumes the deployment directory is a git
# clone of the codebase from an upstream git repo. This script also assumes
# you are using Passenger.
 
deploy_dir=/home/yang/Sites/oa  # deploy dir
 
# You then can run deploy.sh  remotely with ssh:
#
#     ssh user@deployserver "~/deploy.sh"
 
 
echo "=======> Deploying to $deploy_dir <========"
cd $deploy_dir && git pull   

echo 'update bundle'
cd $deploy_dir  && bundle install


echo asset precompile
RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production bundle exec rake kindeditor:assets

echo 'migrate'
RAILS_ENV=production bundle exec rake db:migrate 

# Uncomment if using ThinkingSphinx
# RAILS_ENV=production bundle exec rake ts:rebuild
 
# Restart if any new Rails code

echo Restarting Rails
/etc/init.d/unicorn_oa restart