#
# Cookbook:: lcd_web
# Recipe:: default
#
# Copyright:: 2018, Gonzalo Lopez, All Rights Reserved.
package 'httpd' do
    action :install
end

service 'httpd' do
    action [:enable, :start]
end
