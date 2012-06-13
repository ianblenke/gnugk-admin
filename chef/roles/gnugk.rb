name 'gnugk'
description 'The base role for systems that run GnuGK'
run_list 'recipe[apt]','recipe[ubuntu]','recipe[postgresql]','recipe[application_ruby]'
#, 'recipe[application]', 'recipe[application_ruby]', 'recipe[nginx]', 'recipe[application_nginx]', 'recipe[bluepill]'
default_attributes 'postgresql' => { 'password' => { 'postgres' => 'gnugk' } }

application "gnugk" do
  path "/home/gnugk/admin"
  rails do
    database do
      database "gnugk"
      username "gnugk"
      password "gnugk"
    end
    database_master_role "redmine_database_master"
  end

  memcached do
    role "memcached_master"
    options do
      ttl 1800
      memory 256
    end
  end
end
