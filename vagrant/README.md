# Build a Vagrant VM for Chef deployment of Gnugk and Gnugk Admin

## If you are reading this README on github, you must first clone this project locally, and change directory to it.

## Install Vagrant and VeeWee

First, if you are not using RVM, it is recommended that you do so.

RVM is available here: http://beginrescueend.com/

You can install it as follows:

    $ bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
    $ source ~/.bash_profile

Now, install Ruby 1.9.3 using RVM:

    $ rvm install 1.9.3-p194

If you are reading this README on github, clone the github-admin project locally:

    $ git clone https://github.com/ianblenke/github-admin.git
    $ cd github-admin/chef/

If you do not trust the .rvmrc, you can always run the command in the .rvmrc yourself:

    $ rvm use 1.9.3-p194@gnugk_vagrant --create

Next, you need to install the bundler gem:

    $ gem install bundler
    $ rvm reload

Ok, now that we have RVM and bundler installed, you can now easily install Vagrant and Veewee:

    $ bundle install

## Create a VeeWee Definition:

For this project, we're using the Ubuntu Precise Pangolin 12.04 server amd64 template.

This is defined in the definitions/precise/ folder for you already.

## Build the virtual machine from the definition

    vagrant basebox build 'precise'
    vagrant basebox validate 'precise'
    vagrant basebox export 'precise'

There is now a 'precise.box' file in the current directory.

Now we can spawn up VMs based on that build:

    vagrant box add 'gnugk' 'precise.box'

Now create the Vagrantfile for this VM:

    vagrant init 'gnugk'

Now we can start this VM:

    vagrant up

And ssh into it:

    vagrant ssh


