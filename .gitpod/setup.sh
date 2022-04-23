#!/bin/sh
cd $(dirname "$0") || exit
GITPODDIR=$(pwd)
cd ..
BASEDIR=$(pwd)
cd ..
REDMINEDIR=$(pwd)/redmine
if [ ! -d redmine ]; then
    git clone https://github.com/redmine/redmine.git -b $REDMINE_VERSION
    cd redmine || exit
    cd "$REDMINEDIR"/plugins || exit
    ln -s "$BASEDIR" .
    cp "$GITPODDIR"/database.yml "$REDMINEDIR"/config/
    mkdir "$REDMINEDIR"/.vscode
    cd "$REDMINEDIR"/.vscode || exit
    ln -s "$GITPODDIR"/launch.json .
fi
cd "$REDMINEDIR" || exit
gem install ruby-debug-ide
bundle install
bundle exec rake db:migrate
bundle exec rake redmine:plugins:migrate

IGNOREDIR="$HOME"/.config/git

mkdir -p "$IGNOREDIR"
cp "$GITPODDIR"/ignore "$IGNOREDIR"