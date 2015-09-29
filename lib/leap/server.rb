require 'couchrest'

module LEAP
  class Server < CouchRest::Server

    def initialize
      netrc = File.read('/root/.netrc').split(' ')
      auth = "%{username}:%{password}@" % {username: netrc[3], password: netrc[5]}
      super("http://#{auth}localhost:5984")
    end

    #
    # returns an array of the names of all the per-user storage
    # databases.
    #
    def storage_dbs
      self.databases.select { |db_name|
        db_name =~ /^user-[a-f0-9]{32}$/
      }
    end

  end
end