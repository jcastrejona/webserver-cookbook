#
#
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
package 'apache2' do
  action :install
end
file '/var/www/html/index.html' do
  content 'My first cookbook'
  action :create
end

service 'apache2' do
  action [ :start, :enable ]
end
