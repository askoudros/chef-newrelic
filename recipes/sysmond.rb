#
# Cookbook Name:: newrelic
# Recipe:: sysmond
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


require_recipe "newrelic::default"

package "newrelic-sysmond" do
  action :install
  options "--force-yes"
end

service "newrelic-sysmond" do
  supports :start=>true, :stop=>true, :restart=>false, :reload=>false
  action :nothing
end

execute "sysmond_license" do
  command "nrsysmond-config --set license_key=#{node[:newrelic][:license_key]  }"
  action :run
end

service "newrelic-sysmond" do
  action [:enable, :restart]
end