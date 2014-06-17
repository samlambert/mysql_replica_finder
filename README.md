# MysqlReplicaFinder

A gem that finds all replicas on a given mysql2 connection. MysqlReplicaFinder can also recurse through a replication topology and find all replicas in the chain.

## Usage

Pass in a connection and whether you would like to recurse:

`finder = MysqlReplicaFinder::Finder.new(connection, false)`

Then call:

`finder.replicas`

## Example

Run:

`ruby example/example.rb master.loldatabases.com user password`

to return a list of replicas.

## Installation

Add this line to your application's Gemfile:

    gem 'mysql_replica_finder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mysql_replica_finder

## Contributing

1. Fork it ( http://github.com/<my-github-username>/mysql_replica_finder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
