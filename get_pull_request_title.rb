require 'net/http'
require 'json'

if ARGV.length != 1 then
  puts "Expected only one argument: ENDPOINT_URL"
  exit -1
end

responce = Net::HTTP.get_response(URI(ARGV[0]))
if responce.code == "200"
  puts JSON.parse(responce.body)["title"]
else
  puts "Had an issue calling endpoint..."
  exit -1
end
