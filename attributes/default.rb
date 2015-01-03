#-*- encoding : utf-8 -*-

default.elasticsearch[:name] = 'elasticsearch'
default.elasticsearch[:version] = '1.1.1'

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
