fields = %w(My-Web-Site1-Connections My-Web-site2-Connection My-Mysql-Connection-APP1 My-Mysql-Connection-APP2)
SCHEDULER.every '3s' do
   items = []
   fields.each do |field|
       value = send("fetch_#{field}")
       items << { label: field, value: value }
         	      end

	      send_event('myappcount', { items: items })
end



def My-Web-Site1-Connections

        value = %x(cat /path/to/count/fileWithNumberOrOther)
end

def My-Web-site2-Connection

	value = %x(cat /path/to/count/fileWithNumberOrOther)

end

def My-Mysql-Connection-APP1

       value = %x(cat /path/to/count/fileWithNumberOrOther)
end

def My-Mysql-Connection-APP2

        value = %x(cat /path/to/count/fileWithNumberOrOther)
end

# To be continued
