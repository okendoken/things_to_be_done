require 'set'
arr = IO.readlines("countries.txt")
cities = {}
last_country = ''
arr.each do |line|
  if line.start_with? '!'
    last_country = line.slice(1, line.length - 1).gsub("\n","").to_sym
    cities[last_country] = []
  else
    cities[last_country] << %Q("#{line.gsub("\n","")}")
  end
end

puts '{'
cities.each_key do |k|
  puts %Q(:"#{k}" => [)
  puts "#{cities[k].join ','}"
  puts "],"
end
puts '}'