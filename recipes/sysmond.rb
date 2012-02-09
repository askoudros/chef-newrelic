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
  action :restart
end