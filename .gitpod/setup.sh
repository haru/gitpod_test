#!/bin/sh
cd `dirname $0`
GITPODDIR=`pwd`
cd ..
BASEDIR=`pwd`
cd ..
git clone https://github.com/redmine/redmine.git
cd redmine
REDMINEDIR=`pwd`
cd $REDMINEDIR/plugins
cp -pr $BASEDIR .
cp $GITPODDIR/database.yml $REDMINEDIR/config/
cd $REDMINEDIR
bundle install
bundle exec rake db:migrarte
bundle exec rake redmine:plugins:migrate