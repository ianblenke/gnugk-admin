include_recipe "postgresql::server"

app_user = "gnugk"

postgresql_user app_user do
  password app_user
  privileges :superuser => true, :createdb => true, :inherit => true, :login => true
end

['gnugk','gnugk_development','gnugk_test'].each do |database|
  postgresql_database database do
    owner app_user
    template "template1"
    flags :datconnlimit => 5
    languages [ "plpgsqlu" ]
    modules [ ]
  end
end

execute "user owns app dir" do
  command "chown -R #{app_user} #{ENV['APP_DIR']}"
end

execute "git clone" do
  command "git clone https://github.com/icblenke/gnugk-admin.git"
  cwd ENV['APP_DIR']
  not_if { File.exists?("#{ENV['APP_DIR']}/src/.git/")}
  user app_user
end

execute "checkout HEAD" do
  command "git reset HEAD --hard && git pull"
  cwd "#{ENV['APP_DIR']}/src"
  user app_user
end

execute "bundle" do
  command "bundle"
  user app_user
  cwd "#{ENV['APP_DIR']}/src"
end

execute "rake db:migrate" do
  command "bundle exec rake db:migrate"
  user app_user
  environment 'RACK_ENV' => 'production'
  cwd "#{ENV['APP_DIR']}/src"
end

execute "symlink upstart script for gnugk-admin" do
  command "ln -fs #{ENV['APP_DIR']}/upstart.d/gnugk-admin.conf /etc/init/gnugk-admin.conf"
end

execute "upstart: start gnugk-admin" do
  command "start gnugk-admin"
end

execute "symlink upstart script for gnugk" do
  command "ln -fs #{ENV['APP_DIR']}/upstart.d/gnugk.conf /etc/init/gnugk.conf"
end

execute "upstart: start gnugk" do
  command "start gnugk"
end

