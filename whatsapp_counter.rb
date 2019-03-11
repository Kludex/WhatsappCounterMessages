#!/usr/bin/env ruby

class WhatsappCounter

  attr_reader :people, :messages, :dates

  def initialize(file_name, rank)
    @file_name = file_name
    @rank = rank
    clear_info
    get_info
  end

  def show_rank(min_length=0)
    contact = count_messages
    idx = 1
    contact.sort_by{|key, value| -value}.each do |key, value|
      if idx <= @rank
        puts "Key: #{key}"
        puts "Value: #{value}"
        idx += 1
      else
        break
      end
    end
  end

  def count_messages
    contact = Hash.new(0)
    @people.each do |person|
      contact[person] += 1
    end
    contact
  end

private
  def update_info
    self.clear_info
    self.get_info
  end

  def clear_info
    @dates = Array.new
    @people = Array.new
    @messages = Array.new
  end

  def get_info
    f = File.open(@file_name, "r")
    f.each_line do |line|
      if match = line.match(/(.*) - ([^:]*): (.*)/)
        date, person, message = match.captures
        @dates.push(date)
        @people.push(person)
        @messages.push(message)
      end
    end
    f.close
  end
end

args = ARGV
file_name = args[0]
rank = args[1].to_i
length = args[2].to_i

wtsapp = WhatsappCounter.new(file_name, rank)
wtsapp.show_rank(length)

