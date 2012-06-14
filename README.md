gnugk-admin
===========

GnuGK Admin

## Install dependencies:

NOTE: Chef-solo configuration recipes are underway to automate these steps (using vagrant)

RVM is available here: http://beginrescueend.com/

You can install it as follows:

    $ bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
    $ source ~/.bash_profile

After that, check the rvm requirements:

    $ rvm requirements

For example, to install ruby 1.9.3 under Ubuntu Precise Pangolin, you will need to do something like this:

    $ sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion patch

Next, install Ruby 1.9.3 using RVM:

    $ rvm install 1.9.3-p194

If you are reading this README on github, clone the github-admin project locally:

    $ sudo apt-get install git-core
    $ git clone https://github.com/ianblenke/github-admin.git
    $ cd github-admin

To customize your installation, copy the example static config.yml and database.yml:

    $ cp config/config.yml.example config/config.yml
    $ cp config/database.yml.example config/database.yml

If you do not trust the .rvmrc, you can always run the command in the .rvmrc yourself:

    $ rvm use 1.9.3-p194@gnugk-admin --create

Next, you need to install the bundler gem:

    $ gem install bundler
    $ rvm reload

Ok, now that we have RVM and bundler installed, install the rest of the dependencies:

    $ bundle install

The event database uses mongodb, so we install it first:

    $ sudo apt-get install mongodb

Next, we install PostgreSQL:

    $ sudo apt-get install postgresql-client postgresql postgresql-plperl-8.4 libjson-perl

Add plperlu to your template1 postgres database:

    createlang plperlu template1
    createuser -drs gnugk
    createdb -O gnugk gnugk
    echo "ALTER USER gnugk WITH PASSWORD 'gnugk';" | psql gnugk

Now run the migration

    $ bundle exec rake db:migrate

Fire up the rails server using rackup and thin (gnugk-admin uses EventMachine and Faye):

    $ bundle exec rackup -s thin -E production config.ru 

Run gnugk with the debug trace follower

    $ bundle exec script/debug_trace_follower.rb

Run the gnugk statusport follower

    $ script/statusport_follower.rb

## Todo:

- Add authentication to gnugk-admin (promise!)
- Fixup mongodb full-text search to be faster
- Define upstart scripts to respawn things as need be
- Finish the chef deployment recipes (test in vagrant)

