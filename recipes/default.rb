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
Chef::Log.info("*************************************************************The secret is ***********************************: '#{art_passwd}'")



artifactory_artifact "/tmp/testfile.jar" do
  artifactoryonline "crevise"
  repository "ext-snapshot-local"
  repository_path "/com/javacodegeeks/SampleApplication/1.0-SNAPSHOT/SampleApplication-1.0-20160620.085711-1.jar"
  artifactory_username "admin"
  #artifactory_password "password"
  artifactory_password art_passwd
end
