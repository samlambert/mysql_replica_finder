
require 'mysql2'
require_relative '../lib/mysql_replica_finder.rb'

def client(host, username, password)
  @client ||= Mysql2::Client.new(:host => host, :username => username, :password => password)
end

connection = client(ARGV[0], ARGV[1], ARGV[2])

thing = MysqlReplicaFinder::Finder.new(connection, false)
puts thing.replicas
