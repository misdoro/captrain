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
    #print statns
    db.addStations(statns)

    sleep(2)
  end
end

db.close()