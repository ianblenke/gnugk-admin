#!/usr/bin/bash
# postinstall.sh created from Mitchell's official lucid32/64 baseboxes

date > /etc/vagrant_box_build_time


# Apt-install various things necessary for Ruby, guest additions,
# etc., and remove optional things to trim down the machine.
apt-get -y update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev
apt-get -y install libxml2-dev libyaml-dev
apt-get -y install vim
apt-get -y install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion patch

apt-get clean

# Installing the virtualbox guest additions
apt-get -y install dkms
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm VBoxGuestAdditions_$VBOX_VERSION.iso

# Setup sudo to allow no-password sudo for "admin"
groupadd -r admin
usermod -a -G admin vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# Install NFS client
apt-get -y install nfs-common

# Install RVM
curl -L get.rvm.io | sudo bash -s stable
. /usr/local/rvm/scripts/rvm
alias less=cat
export rvm_is_not_a_shell_function=1
rvm install 1.9.3-p194
unset rvm_is_not_a_shell_function
rvm reload

## Install Ruby from source in /opt so that users of Vagrant
## can install their own Rubies using packages or however.
#wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
#tar xvzf ruby-1.9.3-p194.tar.gz
#cd ruby-1.9.3-p194
#./configure --prefix=/opt/ruby
#make
#make install
#cd ..
#rm -rf ruby-1.9.3-p194

## Install RubyGems 1.8.24
#wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz
#tar xzf rubygems-1.8.24.tgz
#cd rubygems-1.8.24
#/opt/ruby/bin/ruby setup.rb
#cd ..
#rm -rf rubygems-1.8.24

## Installing chef & Puppet
rvm --default use 1.9.3-p194
export PATH=/usr/local/rvm/bin:/usr/local/rvm/gems/ruby-1.9.4-p194/bin:$PATH
gem install chef --no-ri --no-rdoc
gem install puppet --no-ri --no-rdoc

#/opt/ruby/bin/gem install chef --no-ri --no-rdoc
#/opt/ruby/bin/gem install puppet --no-ri --no-rdoc

# Add /opt/ruby/bin to the global path as the last resort so
# Ruby, RubyGems, and Chef/Puppet are visible
#echo 'PATH=$PATH:/opt/ruby/bin/'> /etc/profile.d/vagrantruby.sh
#echo . /usr/share/ruby-rvm/scripts/rvm > /etc/profile.d/vagrantruby.sh
(
  echo '. /usr/local/rvm/scripts/rvm'
  echo 'PATH=/usr/local/rvm/bin:/usr/local/rvm/gems/ruby-1.9.4-p194/bin:$PATH'
  echo 'export PATH'
) > /etc/profile.d/vagrantruby.sh

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Remove items used for building, since they aren't needed anymore
apt-get -y remove linux-headers-$(uname -r) build-essential
apt-get -y autoremove

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp3/*

# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces
exit
