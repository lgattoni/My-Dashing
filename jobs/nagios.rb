 SCHEDULER.every '30s' do

   require 'bundler/setup'
   require 'nagiosharder'

   environments = {
     prod: { url: 'http://myprodserver/cgi-bin/nagios3/', username: 'myuser', password: 'mypassword' },
     preprod: { url: 'http://mypreprodserver/cgi-bin/nagios3/', username: 'myuser', password: 'mypassword' }
   }
   environments.each do |key, env|
   nag = NagiosHarder::Site.new(env[:url], env[:username], env[:password], '3', 'euro', 'false')
   unacked = nag.service_status(:host_status_types => [:all], :service_status_types => [:warning, :critical], :service_props => [:no_scheduled_downtime, :state_unacknowledged, :checks_enabled])

    critical_count = 0
    warning_count = 0
    unacked.each do |alert|
      if alert["status"].eql? "CRITICAL"
        critical_count += 1
      elsif alert["status"].eql? "WARNING"
        warning_count += 1
      end
   end
			      
   status = critical_count > 0 ? "red" : (warning_count > 0 ? "yellow" : "green")

   # nagiosharder may not alert us to a problem querying nagios.
   # If no problems found check that we fetch service status and
   # expect to find more than 0 entries.
   if critical_count == 0 and warning_count == 0
     if nag.service_status.length == 0
       status = "error"
     else
     res = "ok"  
     end
   end
				                                       
     send_event('nagios-' + key.to_s, { criticals: critical_count, warnings: warning_count, status: status, res: res })
   end
 end
