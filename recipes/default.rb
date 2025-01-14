#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2011, Skystack Limited
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

execute "get_gpg_key" do
  command "wget -O - http://download.newrelic.com/548C16BF.gpg | apt-key add -"
  action :run
end

require_recipe "apt"

apt_repository "newrelic" do
  uri "http://apt.newrelic.com/debian"
  components ["newrelic", "non-free"]
  action :add
end

service "newrelic-daemon" do
  supports :start=>true, :stop=>true, :restart=>false, :reload=>false
  action :nothing
end


#service "newrelic-daemon" do
#  case node[:platform]
#  when "CentOS","RedHat","Fedora"
#    service_name "newrelic-daemon"
#  else
#    service_name "newrelic-daemon"
#  end
#  supports :status => true, :restart => true, :reload => true
#  action [ :enable, :start ]
#end