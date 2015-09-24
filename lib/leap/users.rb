require 'couchrest'

module LEAP
  class Users < CouchRest::Database

    def initialize(server)
      super(server, 'users')
    end

    def find_by_login(login)
      record = self.view('User/by_login',
        :reduce => false,
        :startkey => login,
        :endkey => login
      )['rows'].first
      if record
        return self.get(record['id'])
      end
    end

    def all_logins
      self.view('User/by_login',
        :reduce => false
      )['rows'].map {|row|
        row['key']
      }
    end

    def all_active_ids
    end

    def all_ids
    end

  end
end
