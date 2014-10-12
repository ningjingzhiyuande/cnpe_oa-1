#!/bin/bash
 
# deploy.sh
 
# Put this script on your production server and make it executable with chmod
# +x. 
 
# Set the deploy_dir variable to the path on the production server to
# deployment directory. The script assumes the deployment directory is a git
# clone of the codebase from an upstream git repo. This script also assumes
# you are using Passenger.
 
deploy_dir= /home/Sites/oa  # deploy dir
 
# You then can run deploy.sh  remotely with ssh:
#
#     ssh user@deployserver "~/deploy.sh"
 
 
echo "=======> Deploying to $deploy_dir <========"
cd $deploy_dir && git pull   

# Run migrations if any are pulled down
if find Gemfile -type f -mmin -3 | grep '.*'
then
  echo New gem found
  cd $deploy_dir  && bundle install
else
  echo No new gem
fi

echo asset precompile
RAILS_ENV=production bundle exec rake assets:precompile

# Run migrations if any are pulled down
if find db/migrate -type f -mmin -3 | grep '.*'
then
  echo New migrations found
  RAILS_ENV=production bundle exec rake db:migrate 
else
  echo No new migrations
fi
 
# Uncomment if using ThinkingSphinx
# RAILS_ENV=production bundle exec rake ts:rebuild
 
# Restart if any new Rails code

echo Restarting Rails
/etc/init.d/unicorn_oa restart