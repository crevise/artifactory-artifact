#
# Cookbook Name:: artifactory-artifact
# Recipe:: default
#
# Copyright (C) 2016 Yamashita, Yuu
#
# Apache 2.0
#
#
secret = Chef::EncryptedDataBagItem.load_secret(Chef::Config[:encrypted_data_bag_secret])

artifactory_creds = Chef::EncryptedDataBagItem.load("secrets","artifactory", secret)

art_passwd = artifactory_creds["password"]
#Chef::Log.info("*************************************************************The secret is ***********************************: '#{art_passwd}'")



artifactory_artifact "/var/lib/tomcat8/webapps/CounterWebApp.war" do
  artifactoryonline "crevise"
  repository "ext-snapshot-local"
  repository_path "/com/mkyong/CounterWebApp/1.0-SNAPSHOT/CounterWebApp-1.0-20160621.131126-2.war"
  artifactory_username "admin"
  artifactory_password art_passwd
end

service "tomcat8" do
  action :restart
end
