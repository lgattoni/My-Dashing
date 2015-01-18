require 'net/http'
require 'json'
 
# Currently do not have this working with client side SSL, perhaps someone can help with that in the comments.
#  
  host = 'puppet'
  port = '8081'
  http = Net::HTTP.new(host, port)
  nodes_uri = '/v3/metrics/mbean/com.puppetlabs.puppetdb.query.population:type=default,name=num-nodes'
  resources_uri = '/v3/metrics/mbean/com.puppetlabs.puppetdb.query.population:type=default,name=num-resources'
  avg_resources_uri = '/v3/metrics/mbean/com.puppetlabs.puppetdb.query.population:type=default,name=avg-resources-per-node'
  agg_eventcounts_uri = '/v3/aggregate-event-counts?query=%5B%22%3D%22%2C%22latest-report%3F%22%2Ctrue%5D&summarize-by=certname'
   
   SCHEDULER.every '5m', :first_in => 0 do |job|
   num_nodes = JSON.parse(http.get(nodes_uri).body)
   num_resources = JSON.parse(http.get(resources_uri).body)
   avg_resource = JSON.parse(http.get(avg_resources_uri).body)
   agg_eventcounts = JSON.parse(http.get(agg_eventcounts_uri).body)
#    
   send_event('puppetdb_stats', { num_nodes: num_nodes['Value'],
   num_resources: num_resources['Value'],
   avg_resource: avg_resource['Value'].to_f.round(2),
   successes: agg_eventcounts['successes'],
   failures: agg_eventcounts['failures'] })
   end 
