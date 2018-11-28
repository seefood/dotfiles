#!/bin/bash

# Quick and dirty setup of the Bluevine dev env. - Stage 3

# Adapted from https://docs.google.com/document/d/1j1DZ9rb8g0XKubFf26SRlCpKvy8qGrku30LxbxMqZHE/edit

#set -e

### DevOps env. Setup

gpg --list-key 409B6B1796C275462A1703113804BB82D39DC0E3 || \
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.4.1
source ~/.rvm/scripts/rvm

rvm use 2.4.1

rvm gemset create kitchen
cd ~/bluevine/chef-repo
unset AWS_ACCESS_KEY AWS_ACCESS_KEY_ID AWS_DEFAULT_REGION \
  AWS_SECRET_ACCESS_KEY AWS_SECRET_KEY AWS_SESSION_TOKEN
rvm gemset use kitchen
ruby kitchen_env.rb

### TODO: Create the aws credentials file automatically from the  automated zip.


