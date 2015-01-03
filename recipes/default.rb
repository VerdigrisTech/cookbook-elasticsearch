#-*- encoding : utf-8 -8-

# Environment defaults
template "etc.default" do
  path    "/etc/default/elasticsearch"
  source  "etc.default.erb"
  owner   node[:elasticsearch][:user]
  group   node[:elasticsearch][:user]
  mode    0755
end

# Init.d script
template "etc.init.d" do
  path   "/etc/init.d/elasticsearch"
  source "etc.init.d.erb"
  owner 'root'
  mode 0755
end
