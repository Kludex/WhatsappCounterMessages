#!/usr/bin/env ruby

class WhatsappCounter
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
        puts "Key: " + key
        puts "Value: " + value.to_s
        puts "Words: " + count_words_from(key, min_length).to_s
        puts "Laughs: " + count_laughs(key).to_s
        idx += 1
      else
        break
      end
    end
  end

  def count_laughs(name=nil)
    sum = 0 
    if name.nil?
      @messages.each do |message|
        words = message.split
        words.each do |word|
          if word.include?("haha") or word.include?("kkk")
            sum += 1
          end
        end
      end
    else
      @messages.zip(@people) do |message, person|
        words = message.split
        words.each do |word|
          if word.include?("haha") and person.include?(name)
            sum += 1
          end
        end
      end
    end

    return sum
  end

  def count_words(min_length=0)
    sum = 0
    @messages.each do |message|
      words = message.split
      words.each do |word|
        if word.length >= min_length
          sum += 1
        end
      end
    end
    return sum
  end

  def count_words_from(name, min_length=0)
    sum = 0
    @messages.zip(@people) do |message, person|
      words = message.split
      words.each do |word|
        if word.length >= min_length and person.include?(name)
          sum += 1
        end
      end
    end
    return sum
  end

  def count_messages
    contact = {}
    @people.each do |person|
      if person.instance_of? String
        if contact.has_key?(person)
          contact[person] += 1
        else
          contact[person] = 1
        end
      end
    end
    contact
  end

  def set_file(file_name)
    @file_name = file_name
    self.update_info
  end

  def get_people
    @people
  end

  def get_messages
    @messages
  end

  def get_dates
    @dates
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

