#-*- encoding : utf-8 -*-

default.elasticsearch[:name] = 'elasticsearch'
default.elasticsearch[:version] = '1.1.1'
default.elasticsearch[:checksum][:deb] = '4e43be2e1e8d0bc41f5c64b321d8feb85f1e2f9e9ce7bd64359ec4c7e16fe999  elasticsearch-1.1.1.deb'
default.elasticsearch[:checksum][:rpm] = 'e7b062332809a0dd2ade9ef5005f1bf5bdde595378f0874ac8ba90016cf889d1  elasticsearch-1.1.1.noarch.rpm'
default.elasticsearch[:checksum][:tar_gz] = '564cd91bb55cc9d922e59679b0f666e0b4f0bd8c2b9cafd5fce4c55f3f50a835  elasticsearch-1.1.1.tar.gz'

default.elasticsearch[:user] = node.elasticsearch[:name]
default.elasticsearch[:install_dir] = "/usr/share"

# Paths
default.elasticsearch[:path][:home] = [node.elasticsearch[:install_dir], node.elasticsearch[:name]].join('/')
default.elasticsearch[:path][:conf] = ['/etc', node.elasticsearch[:name]].join('/')
default.elasticsearch[:path][:data] = ['/var/lib', node.elasticsearch[:name]].join('/')
default.elasticsearch[:path][:plugins] = [node.elasticsearch[:path][:home], 'plugins'].join('/')
default.elasticsearch[:path][:logs] = ['/var/log', node.elasticsearch[:name]].join('/')
default.elasticsearch[:path][:pids] = '/var/run'

# Files
default.elasticsearch[:executable_file] = [node.elasticsearch[:path][:home], 'bin', 'elasticsearch'].join('/')
default.elasticsearch[:configuration_file] = [node.elasticsearch[:path][:conf], 'elasticsearch.yml'].join('/')

# Memory
default.elasticsearch[:allocated_memory] = "#{(node.memory.total.to_i * 0.6 ).floor / 1024}m"
default.elasticsearch[:thread_stack_size] = "256k"
default.elasticsearch[:lock_memory] = true

# Cluster
default.elasticsearch[:cluster][:name] = node.elasticsearch[:name]
