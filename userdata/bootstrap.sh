#!/bin/bash

# Add yarn repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# Add pg repo
curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ debian-20.04 main' > /etc/apt/sources.list.d/pgdg.list

sudo apt update

# Install packages
sudo apt-get install build-essential gnupg2 curl wget ssh-client apt-transport-https ca-certificates \
gnupg2 git fail2ban ufw nano ssh-client libpq-dev apt-transport-https ca-certificates hicolor-icon-theme \
libcanberra-gtk* libgl1-mesa-dri libgl1-mesa-glx libpangox-1.0-0 libpulse0 libv4l-0 fonts-symbola \
protobuf-compiler libprotobuf-dev pkg-config libldap2-dev libidn11-dev yarn postgresql postgresql-contrib \
postgresql-client libssl-dev -y

# Install asdf
git clone ${asdf_git_repo_url} ~/.asdf
echo '. /root/.asdf/asdf.sh' >> ~/.bash_profile
echo '. /root/.asdf/completions/asdf.bash' >> ~/.bash_profile
. ~/.bash_profile

# Update asdf to latest package
asdf update

# Install nodejs
asdf plugin add nodejs ${asdf_nodejs_git_repo_url}
asdf install nodejs ${nodejs_version}
asdf global nodejs ${nodejs_version}

# Install ruby
asdf plugin add ruby ${asdf_ruby_git_repo_url}
asdf install ruby ${ruby_version}
asdf global ruby ${ruby_version}
asdf plugin-add direnv

# Confirm completion
touch ${script_loc}/bootstrap.done