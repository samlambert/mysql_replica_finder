require 'mysql2'

module MysqlReplicaFinder

  class Finder

    def initialize(connection, recurse=false)
      @replicas = []
      @primary_connection = connection
      @recurse = recurse
      fetch
    end

    def fetch
      unless @recurse
        @replicas << get_replica_hosts_from_connection(@primary_connection)
      else
        get_replica_hosts_from_connection_rec(@primary_connection)
      end
    end
   
    def replicas
      @replicas
    end

    # Returns an array or replicas that are connected
    def get_replica_hosts_from_connection(connection)
      replicas = []
      rows = select_all(connection, "SHOW PROCESSLIST")
      rows.each do |row|
        if row["Command"] == "Binlog Dump"
          replicas.push(row['Host'].split(":")[0])
        end
      end
      replicas
    end

    def select_all(connection, query)
      connection.query(query)
    end

    def transform_replica_to_connection(host)
      Mysql2::Client.new(@primary_connection.query_options.merge({ :host => host}))
    end

    def get_replica_hosts_from_connection_rec(connection)
      if connection.kind_of? Array
        connection.each {|conn| get_replicas(conn) }
      else
        get_replica_hosts_from_connection(connection).map do |replica|
          @replicas << replica
          get_replica_hosts_from_connection_rec(transform_replica_to_connection(replica))
        end
      end
    end

  end
end

