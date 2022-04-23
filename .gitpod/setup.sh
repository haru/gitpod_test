#!/bin/sh
cd $(dirname "$0") || exit
GITPODDIR=$(pwd)
IGNOREDIR="$HOME"/.config/git
mkdir -p "$IGNOREDIR"
cp "$GITPODDIR"/ignore "$IGNOREDIR"
cd ..
BASEDIR=$(pwd)
PLUGIN_NAME=$(basename "$BASEDIR")
cd ..
REDMINEDIR=$(pwd)/redmine
if [ ! -d redmine ]; then
    git clone https://github.com/redmine/redmine.git -b "$REDMINE_VERSION"
    cd redmine || exit
    cd "$REDMINEDIR"/plugins || exit
    ln -s "$BASEDIR" .
    cp "$GITPODDIR"/database.yml "$REDMINEDIR"/config/
    mkdir "$REDMINEDIR"/.vscode
    cd "$REDMINEDIR"/.vscode || exit
    ln -s "$GITPODDIR"/launch.json .
fi
cd "$REDMINEDIR" || exit
sed "s/__PLUGIN__NAME/$PLUGIN_NAME/" "$GITPODDIR"/gitpod.code-workspace > "$REDMINEDIR"/gitpod.code-workspace
gem install ruby-debug-ide
bundle install
bundle exec rake db:migrate
bundle exec rake redmine:plugins:migrate
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rake redmine:plugins:migrate RAILS_ENV=test

