#!/usr/bin/env ruby
class DBClient
  
  def initialize(dbhost='localhost',dbname='captrain',dbuser='captrain',dbpass='pctpass')
    begin
      @conn = Mysql.new(dbhost,dbuser,dbpass,dbname)
      @conn.autocommit(false)
      @stmt = @conn.prepare("INSERT IGNORE INTO stations(id,latitude,longitude,name) VALUES(?,?,?,?)")
      @getkeystmt = @conn.prepare("Select keystr,numsta from usedkeys where keystr=?;")
      @putkeystmt = @conn.prepare("INSERT IGNORE INTO usedkeys(keystr,numsta) VALUES(?,?)")
    rescue Mysql::Error => e
      puts e
    end
  end
  
  def verifykey(keytxt)
    haskey=@getkeystmt.execute(keytxt)
    if haskey.num_rows>0
      haskey.each do |val|
	return val[1]
      end
    else
      return -1
    end
  end
  
  def setkey(keytxt,numsta)
    @putkeystmt.execute(keytxt,numsta)
    @conn.commit
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