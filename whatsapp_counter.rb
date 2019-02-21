#!/usr/bin/env ruby

args = ARGV
file_name = args[0]
rank = args[1].to_i

contact = {}

f = File.open(args[0], "r")
f.each_line do |line|
  if match = line.match(/(.*) - ([^:]*): (.*)/)
    date, person, message = match.captures
  end
  if person.instance_of? String
    if contact.has_key?(person)
      contact[person] += 1
    else
      contact[person] = 1
    end
  end
end
f.close

contact.sort_by{|key, value| -value}.each do |key, value|
  if rank > 0
    puts "Key: " + key
    puts "Value: " + value.to_s
    rank -= 1
  else
    break
  end
end
