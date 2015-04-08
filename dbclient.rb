#!/usr/bin/env ruby
class DBClient
  
  def initialize(dbhost='localhost',dbname='captrain',dbuser='captrain',dbpass='pctpass')
    begin
      @conn = Mysql.new(dbhost,dbuser,dbpass,dbname)
      @conn.autocommit(false)
      @stmt = @conn.prepare("INSERT IGNORE INTO stations(id,latitude,longitude,name) VALUES(?,?,?,?)")
      
    rescue Mysql::Error => e
      puts e
    end
  end
  
  def addStations(stations)
    stations.each do |station|
      puts station["name"]+"\n"
      @stmt.execute(station["id"],station["latitude"],station["longitude"],station["name"])
    end
    @conn.commit
  end
  
  def close()
    @conn.commit if @conn
    @stmt.close if @stmt
    @conn.close if @conn
  end
  
end