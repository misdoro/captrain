require "net/https"
require "uri"
require 'json'
require 'mysql'
$LOAD_PATH << '.'
require 'ctrapiclient'
require 'dbclient'

apc=Ctrapiclient.new()

db=DBClient.new()

#statns=apc.query_q('ae')

#db.addStations(statns)


('a'..'z').each do |l1|
  ('a'..'z').each do |l2|
    stn=l1+l2
    print stn+"\n"
    statns=apc.query_q(stn)
    db.addStations(statns)
    if statns.size>=8
      ('a'..'z').each do |l3|
	statns=apc.query_q(stn+l3)
	 db.addStations(statns)
	 puts "third loop"
	 puts statns.inspect
      end
    end
    #print statn
    sleep(1)
  end
end

db.close()