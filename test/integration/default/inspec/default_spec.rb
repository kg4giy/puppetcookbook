# Tests for the puppet install

describe file('/tmp/puppetlabs-release-pc1-el-7.noarch.rpm') do
	it { should exist }
end

describe package('puppetlabs') do
	it { should be_installed }	
end

describe service('puppetserver') do 
  	it { should be_running }
end

describe port(8140) do
	it { should be_listening }
end

describe service (firewall) do
	it { should be_running }	
end

describe file 'var/opt/puppetlabs/puppetserver' do
	it { should be_directory}
	its('mode') { should cmp '0755' }
	its('owner') { should eq 'puppet' }
	its('group') { should eq 'puppet' }


describe file 'etc/puppetlabs/puppetserver/conf.d/puppetserver.conf' do
	its ('content') { should include 'master-var-dir = /var/opt/puppetlabs/puppetserver' }
end

describe gem('bundler') do
	it { should be_installed }
end
