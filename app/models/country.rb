class Country
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    elsif(ENV['DATABASE_PASSWORD'])
        DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'world-map-api_development', :password => ENV['DATABASE_PASSWORD'], :user => "postgres"})
    else
        DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'world-map-api_development'})
    end
    

    def self.all
        results = DB.exec("SELECT * FROM user_country;")
        return self.data_transform_country(results)
    end


    def self.find(id)
        results = DB.exec("SELECT * FROM user_country WHERE trip_id=#{id};")
        return self.data_transform_country(results)
    end

    def self.findByUser(userid)
        results = DB.exec(
            <<-SQL
                SELECT *
                FROM user_country
                WHERE user_id = #{userid};
            SQL
        )
        return self.data_transform_country(results)
    end

    def self.create(opts)
        results = DB.exec(
            <<-SQL
                INSERT INTO user_country (user_id, country_code, trip_date, type)
                VALUES ( #{opts["user_id"]}, '#{opts["country_code"]}', '#{opts["trip_date"]}', '#{opts["type"]}'  )
                RETURNING trip_id, user_id, country_code, trip_date, type
            SQL
        )
        return self.data_transform_country(results)
    end

    def self.delete(id)
        results = DB.exec("DELETE FROM user_country WHERE trip_id=#{id}")
        return { "deleted" => true }
    end


    def self.update(id, opts)
        results = DB.exec(
            <<-SQL
                UPDATE user_country
                SET user_id=#{opts["user_id"]}, country_code='#{opts["country_code"]}', trip_date='#{opts["trip_date"]}', type='#{opts["type"]}'
                WHERE trip_id = #{id}
                RETURNING trip_id, user_id, country_code, trip_date, type
            SQL
        )
        return self.data_transform_country(results)

    end

    def self.data_transform_country(user_country_rows)
        transformed_data = []

        user_country_rows.each do |trip|
            new_trip = {
                "trip_id" => trip["trip_id"].to_i,
                "user_id" => trip["user_id"].to_i,
                "country_code" => trip["country_code"],
                "trip_date" => trip["trip_date"],
                "type" => trip["type"],
            }
            transformed_data << new_trip
        end
        return transformed_data
    end

end