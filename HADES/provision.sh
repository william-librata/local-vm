#!/bin/bash

# Update repo
apt-get update

# Install apt packages
apt-get install vim -y
apt-get install git -y
apt-get install git-flow -y
apt-get install python3-pip -y
apt-get install awscli -y
apt-get install python3-venv -y
apt-get install python3-sphinx -y
apt-get install virtualenv -y
apt-get install postgresql-10 -y
apt-get install default-jre -y
apt-get install graphviz -y
apt-get install terminator -y
snap install pycharm-community --classic

# Install public key
KEY=$(cat "/Security/RSA KEYS/20180301/20180301.PublicKey")
if [ -z "$(grep "$KEY" /home/vagrant/.ssh/authorized_keys )" ]; then echo $KEY >> /home/vagrant/.ssh/authorized_keys; echo key added.; fi;

# Install private key
sudo -u vagrant cp "/Security/RSA KEYS/20180301/20180301.PrivateKey" /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa

# Setup ssh 
rm -f /home/vagrant/.ssh/config
sudo -u vagrant touch /home/vagrant/.ssh/config
sudo -u vagrant echo "Host git-codecommit.*.amazonaws.com" >> /home/vagrant/.ssh/config
sudo -u vagrant echo "  User APKAJ6UGW3Y77G3EHQ6Q" >> /home/vagrant/.ssh/config
sudo -u vagrant echo "  StrictHostKeyChecking no" >> /home/vagrant/.ssh/config

# Clone projects
sudo -u vagrant git clone ssh://git-codecommit.ap-southeast-2.amazonaws.com/v1/repos/etl /home/vagrant/Project/etl/
sudo -u vagrant git clone ssh://git-codecommit.ap-southeast-2.amazonaws.com/v1/repos/cloud_formation_template /home/vagrant/Project/cloud_formation_template/
sudo -u vagrant git clone ssh://git-codecommit.ap-southeast-2.amazonaws.com/v1/repos/data_stream_publisher /home/vagrant/Project/data_stream_publisher/
sudo -u vagrant git clone ssh://git-codecommit.ap-southeast-2.amazonaws.com/v1/repos/data_stream_consumer /home/vagrant/Project/data_stream_consumer/
sudo -u vagrant git clone ssh://git-codecommit.ap-southeast-2.amazonaws.com/v1/repos/backend /home/vagrant/Project/backend/

# Setup virtual environment
#sudo -u vagrant python3 -m venv /home/vagrant/Project/etl/venv/