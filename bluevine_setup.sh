#!/bin/bash

# Quick and dirty setup of the Bluevine dev env.

# Adapted from https://docs.google.com/document/d/1j1DZ9rb8g0XKubFf26SRlCpKvy8qGrku30LxbxMqZHE/edit

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Basic brew stuff (some may already be installed?)
  brew install vagrant-completion
  brew cask install chef-workstation
else
  if ! hash vagrant 2> /dev/null ; then
    wget https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_x86_64.deb && \
      sudo dpkg -i vagrant_2.2.2_x86_64.deb && \
      rm vagrant_2.2.2_x86_64.deb
  fi

  if ! hash rvm 2> /dev/null ; then
    sudo apt-add-repository -y ppa:rael-gc/rvm
    sudo apt-get update
    sudo apt-get install -y rvm
    sudo usermod $USER -a -G rvm

    echo "***** You now need to log out, log in, and run $0 again, so you can be in the rvm user group"
    exit

    # At this point, the Ubuntu people may need to logout and login again to get rvm group membership.

  fi
  source /etc/profile.d/rvm.sh
  rvm install 2.4.1
  rvm use 2.4.1

  if ! hash knife 2>/dev/null ; then
    wget https://packages.chef.io/files/stable/chef-workstation/0.2.41/ubuntu/18.04/chef-workstation_0.2.41-1_amd64.deb && \
      sudo dpkg -i chef-workstation_0.2.41-1_amd64.deb
  fi
fi
vagrant plugin install vagrant-triggers vagrant-cachier vagrant-share

# Creating the virtualenv
pip3 install virtualenvwrapper
mkvirtualenv bluevine
workon bluevine

# Install the required pip3 packages on your new virtual environment:
pip3 install pylint pylint-django fabric3 boto3 requests awscli virtualenv\
    virtualenvwrapper cryptography sendgrid==3.6.0

# Allow non-standard workspace locations.
PROJECT_HOME=${PROJECT_HOME:=~/bluevine}

# Basic infrastructure:
mkdir -p ${PROJECT_HOME} && cd ${PROJECT_HOME}
for repo in system chef-repo r2d2 ; do
  [[ -d ${repo}/.git ]] || git clone git@github.com:bluevine-dev/${repo}.git
  [[ "$repo" = "r2d2" ]] || git -C ${repo}/ config pull.rebase false
done

environments="development staging production"

for envi in $environments ; do
  [[ -d ${PROJECT_HOME}/${envi} ]] || cp -r "system/misc/dev-kit/${envi}" . > /dev/null || true
  ln -sf ${PROJECT_HOME}/chef-repo "${envi}/"
  ln -sf ${PROJECT_HOME}/system/common/env "${envi}/.env"
  ln -sf ${PROJECT_HOME}/system/common/env "${envi}/env-${envi}.sh"
  ln -sf chef-repo/fabfile "${envi}/fabfile"
done

bash ${PROJECT_HOME}/chef-repo/cookbooks/bluevine-dev/clone-repos.sh

# Future addition, when it stabilizes.
#cd r2d2/
#make install_cli
#. ~/.bash_aliases.d/dev.bluevine.sh
#r2d2 projects init

# Development environment: (~/bluevine/development):
ln -sf ${PROJECT_HOME}/chef-repo/cookbooks/bluevine-dev ${PROJECT_HOME}/development/src
cp ${PROJECT_HOME}/chef-repo/cookbooks/bluevine-dev/VagrantfileUbuntu16Py36R2D20180514.sample \
  ${PROJECT_HOME}/development/src/Vagrantfile

sh ${PROJECT_HOME}/chef-repo/cookbooks/bluevine-dev/install-git-hooks.sh

# At this point break for the user to put the .chef/user.pem in the right locations.
