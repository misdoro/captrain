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

def search_level(captclient, db, sstr)
  depth=5
  servlim=8
  [*('a'..'z'),' ','-'].reverse.each do |ltr|
    stn=sstr+ltr
    puts stn
    statns=captclient.query_q(stn)
    db.addStations(statns)
    sleep(1)
    if statns.size>=servlim && stn.size<=depth
      search_level(captclient,db,stn)
    end
  end
end

#Recursive:
search_level(apc,db,"")

#7143 with three levels
#('a'..'z').each do |l1|
#  ('a'..'z').each do |l2|
#    stn=l1+l2
#    print stn+"\n"
#    statns=apc.query_q(stn)
#    db.addStations(statns)
#    if statns.size>=8
#      ('a'..'z').each do |l3|
#	statns=apc.query_q(stn+l3)
#	 db.addStations(statns)
#	 puts "third loop "+stn+l3
#	 puts statns.inspect
#	sleep(1)
#      end
#    end
#    #print statn
#    sleep(1)
#  end
#end

db.close()
