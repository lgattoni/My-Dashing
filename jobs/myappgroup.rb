


fields = %w(AppGroup1 AppGroup2 AppGroup3 AppGroup4)
SCHEDULER.every '3s' do
   items = []
   fields.each do |field|
       value = send("fetch_#{field}")
       items << { label: field, value: value }
         	      end

	      send_event('myappgroup', { items: items })
end

def AppGroup1

	value = %x(cat /pathfile/file) 
end

def AppGroup2

	value = %x(cat /pathfile/file)
end

def AppGroup3

	        value = %x(cat /pathfile/file)
end

def AppGroup4

	        value = %x(cat /pathfile/file)
end

