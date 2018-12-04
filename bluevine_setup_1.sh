#!/bin/bash

# Quick and dirty setup of the Bluevine dev env.

# Adapted from https://docs.google.com/document/d/1j1DZ9rb8g0XKubFf26SRlCpKvy8qGrku30LxbxMqZHE/edit

set -e

# Basic brew stuff (some may already be installed?)
brew install bash-completion vagrant-completion
brew cask install chef-workstation
vagrant plugin install vagrant-omnibus vagrant-triggers \
                       vagrant-cachier vagrant-share

# Install the required pip3 packages on your new virtual environment:
pip3 install pylint pylint-django fabric3 boto3 requests awscli virtualenv\
    virtualenvwrapper cryptography sendgrid==3.6.0

# Allow non-standard workspace locations.
WS=${WS:=~/bluevine}

# Basic infrastructure:
mkdir -p ${WS} && cd ${WS}
for repo in system chef-repo ; do
  git clone git@github.com:bluevine-dev/${repo}.git
  git -C ${repo}/ config pull.rebase false
done

environments="$(cd system/misc/dev-kit/ ; echo [a-z]*)"

for envi in $environments ; do
  [[ -d ${WS}/${envi} ]] || cp -r system/misc/dev-kit/${envi} . > /dev/null || true
  ln -sf ${WS}/chef-repo ${envi}/
  ln -sf ${WS}/system/common/env ${envi}/.env
  ln -sf ${WS}/system/common/env ${envi}/env-${envi}.sh
  ln -sf chef-repo/fabfile ${envi}/fabfile
done

bash ${WS}/chef-repo/cookbooks/bluevine-dev/clone-repos.sh

# Development environment: (~/bluevine/development):
ln -sf ${WS}/chef-repo/cookbooks/bluevine-dev ${WS}/development/src
cp ${WS}/chef-repo/cookbooks/bluevine-dev/VagrantfileUbuntu16Py3D20180514.sample \
    ${WS}/development/src/Vagrantfile

sh ${WS}/chef-repo/cookbooks/bluevine-dev/install-git-hooks.sh

# At this point break for the user to put the .chef/user.pem in the right locations.
