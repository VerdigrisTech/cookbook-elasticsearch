#-*- encoding : utf-8 -8-

template "etc.default" do
  path    "/etc/default/elasticsearch"
  source  "etc.default.erb"
  owner   node[:elasticsearch][:user]
  group   node[:elasticsearch][:user]
  mode    0755
end
