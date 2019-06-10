class User
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    elsif(ENV['DATABASE_PASSWORD'])
        DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'world-map-api_development', :password => ENV['DATABASE_PASSWORD'], :user => "postgres"})
    else
        DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'world-map-api_development'})
    end

    def self.all
        results = DB.exec("SELECT * FROM users;")
        return results.map do |result|
            {
                "user_id" => result["user_id"].to_i,
                "username" => result["username"]
            }
        end
    end

    def self.find(id)
        p "User.find id: #{id}"
        results = DB.exec("SELECT * FROM users WHERE user_id=#{id};")
        result = results.first
        return self.data_transform_users(results)
    end

    def self.find_by_username(username)
        results = DB.exec("SELECT * FROM users WHERE username='#{username}';")
        result = results.first
        return self.data_transform_users(results)
    end

    def self.create(opts)
        
        opts["password"] = self.hash_password(opts["password"])
        
        results = DB.exec(
            <<-SQL
                INSERT INTO users (username, password)
                VALUES ( '#{opts["username"]}', '#{opts["password"]}')
                RETURNING user_id, username, password;
            SQL
        )
        result = results.first
        return self.data_transform_users(results)
    end

    def self.hash_password(password)
        BCrypt::Password.create(password).to_s
    end

    # Not yet needed

    def self.delete(id)
    end

    def self.update(id, opts)
    end

    def self.data_transform_users(results)
        if(results.any?) 
            result = results.first
            return {
                    "user_id" => result["user_id"].to_i,
                    "username" => result["username"],
                    "password" => result["password"]
            }
        else
            p 'empty results!'
            return {
                "error" => "not found"
            }
        end

    end

end