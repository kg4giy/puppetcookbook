#
# Cookbook Name:: puppet
# Recipe:: default
#

# Enables the repository
remote_file '/tmp/puppetlabs-release-pc1-el-7.noarch.rpm' do
  source 'http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm'
  notifies :run, 'execute[sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm] '
end

# Installs the application
package 'puppetserver'

# Firewall manipulation
execute 'firewall-cmd' do
  command 'firewall-cmd --permanent --zone=public --add-port=8140/tcp'
end

execute 'firewall-cmd' do
  command 'firewall-cmd --reload'
end

file '/var/opt/puppetlabs/puppetserver' do
	owner 'puppet'
	group 'puppet'
	mode '0755'
	action :create
end

puppet_file = 'etc/puppetlabs/puppetserver/conf.d/puppetserver.conf'

file puppet_file do
	content 'master-var-dir = /var/opt/puppetlabs/puppetserver'
end

# JVM Settings (optional)
# /etc/sysconfig/puppetserver and change the following line:
# Modify this if you'd like to change the memory allocation, enable JMX, etc.
# JAVA_ARGS="-Xms512m -Xmx512m

# Install bundler (optional)

gem_package 'bundler'
	action :install
end
