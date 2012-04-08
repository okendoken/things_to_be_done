require 'set'
arr = IO.readlines("countries2.txt")
cities = {}
last_country = ''
arr.each do |line|
  country = line[/.*;/][/.*[^;]/]
  cities[country] = [] if cities[country].nil?
  cities[country] << %Q("#{line[/;.*\n/][/[^;\s].*/]}")
end

puts '{'
cities.each_key do |k|
  puts %Q(:"#{k}" => [)
  puts "#{cities[k].join ','}"
  puts "],"
end
puts '}'