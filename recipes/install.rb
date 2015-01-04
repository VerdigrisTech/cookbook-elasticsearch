src_filename = "elasticsearch-#{node[:elasticsearch][:version]}"
src_path = "#{Chef::Config[:file_cache_path]}/#{package_filename}"
src_url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/"
install_path = "#{node[:elasticsearch][:install_dir]}"

case node[:platform_family]
# Debian Linux family
when "debian"
  # Download ElasticSearch .deb file
  remote_file "#{src_path}.deb" do
    source "#{src_url}#{src_filename}.deb"
    mode 0644
    checksum node[:elasticsearch][:checksum][:deb]
  end

  # Install the ElasticSearch Debian package
  dpkg_package "elasticsearch" do
    source "#{src_path}.deb"
    action :install
  end
# RedHat/Fedora Linux family
when "rhel", "fedora"
  # Download ElasticSearch .rpm file
  remote_file "#{src_path}.noarch.rpm" do
    source "#{src_url}#{src_filename}.noarch.rpm"
    mode 0644
    checksum node[:elasticsearch][:checksum][:rpm]
  end

  # Install the ElasticSearch RPM package
  rpm_package "elasticsearch" do
    source "#{src_path}.noarch.rpm"
    action :install
  end
# All other platforms
else
  # Create group and user
  group node[:elasticsearch][:user] do
    action :create
  end

  user node[:elasticsearch][:user] do
    home "/home/elasticsearch"
    shell "/bin/bash"
    gid node[:elasticsearch][:user]
    comment "ElasticSearch user"
    supports :manage_home => false
    action :create
  end

  # Download tar.gz package
  remote_file "#{src_path}.tar.gz" do
    source "#{src_url}#{src_filename}.tar.gz"
    mode 0644
    checksum node[:elasticsearch][:checksum][:tar_gz]
  end

  # Install the package
  bash "extract_archive" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    code <<- EOH
      tar xvzf #{src_filename}.tar.gz -C #{install_path}
      mv "#{node[:elasticsearch][:path][:home]}-#{node[:elasticsearch][:version]}" #{node[:elasticsearch][:path][:home]}
    EOH
    not_if { ::File.exists?(node[:elasticsearch][:path][:home]) }
  end
end
