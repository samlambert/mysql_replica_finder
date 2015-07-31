require 'mysql2'

module MysqlReplicaFinder

  class Finder

    def initialize(connection, recurse=false)
      @replicas = []
      @primary_connection = connection
      @recurse = recurse
    end

    def fetch
      unless @recurse
        @replicas << replica_hosts_from_connection(@primary_connection)
      else
        replica_hosts_from_connection_rec(@primary_connection)
      end
    end
   
    def replicas
      fetch
      @replicas
    end

    # Returns an array of replicas that are connected
    def replica_hosts_from_connection(connection)
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

    def replica_hosts_from_connection_rec(connection)
      replica_hosts_from_connection(connection).map do |replica|
        @replicas << replica
        replica_hosts_from_connection_rec(transform_replica_to_connection(replica))
      end
    end
    
  end
end

