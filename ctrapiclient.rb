#!/usr/bin/env ruby
class Ctrapiclient
  
  def initialize(url="https://www.capitainetrain.com/api/v4/")
      
    #Prepare HTTP conntection
    @uri = URI.parse(url.concat("stations"))
    
    #Session identifier
    #cts="RWRxdVViaS9mN21ZMFFKaXY2VjEwT056RzMrN0s5bExHVGR1N1FRVGlYdXg3aDdJSlExUGxubTJUbFVzRmZjUGJuTDBINnk4RkR0NjNmSW1SRjhKZGk1ZzZuaE1nZDJhUnc5aitxbTFyZDVWT2hMQ0Z2aWxrc1FzTHA2LzhDbEJOYncyWDF2N0xJOVdyaGVablEwWDNwUDRXdExHWjVMK2NpUGcxcWVBSEF6QzE1QWJPZFpWVmorSVZCVWc4ZGh6LS1vUWlqVW4vWGUyckdHS0V4RnJtdnh3PT0%3D--498413816413ade3eb3bf820f176569d308a3492"
    
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end
  
  def query_q(qval="Aaa")
    args = {q: "#{qval}"}
    @uri.query = URI.encode_www_form(args)
    request = Net::HTTP::Get.new(@uri.request_uri)
    response = @http.request(request)
    JSON.parse(response.body)["stations"]
  end
end