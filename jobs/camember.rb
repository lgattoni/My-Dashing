


SCHEDULER.every '15s' do
	data = []
	poles = {
		"PEGASE" => "PEG",
		"IO"     => "IO",
		"ARIANE" => "AR",
		"ATD"    => "ATD",
		"SIM"    => "SIM",
		"DOYWS" => "DOYWSF"
	}
	poles.each do |pole,label|
		val = File.open("/data/pivot/compteur/#{pole}/cpt.txt", "r").readline.chomp.to_i
		data << { label: label, value: val }
	end
#data = [ 
#	{ label: "IO", value: val }, 
#	{ label: "PEG", value: 67 },
#	{ label: "AR", value: 56 }, 
#	{ label: "ATD", value: 76 },
#]

	send_event 'bookmarks_frequency', { value: data }

end
