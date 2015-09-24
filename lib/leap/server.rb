require 'couchrest'

module LEAP
  class Server < CouchRest::Server
    def initialize
      netrc = File.read('/root/.netrc').split(' ')
      auth = "%{username}:%{password}@" % {username: netrc[3], password: netrc[5]}
      super("http://#{auth}localhost:5984")
    end
  end
end