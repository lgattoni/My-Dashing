# Populate the graph with some random points
points = []
(1..10).each do |i|
  points << { x: i, y: 4000 }
end
last_x = points.last[:x]

SCHEDULER.every '2s' do
  points.shift
  last_x += 1
  last_y = %x(cat /data/pivot/compteur/All/cpt.txt)
  ##points << { x: last_x, y: 500  }
  
  points << { x: last_x, y: last_y }

  send_event('total', points: points)
end
