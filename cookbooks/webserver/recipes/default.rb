#
# Configure a simple Nginx web server.
#

package 'nginx' do
  action :install
end

directory node['webserver']['document_root'] do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  recursive true
  action :create
end

template "#{node['webserver']['document_root']}/index.html" do
  source 'index.html.erb'
  owner 'www-data'
  group 'www-data'
  mode '0644'
end

service 'nginx' do
  action [:enable, :start]
end
