require './environment'

period = Period.new

period.add(1, 5)
period.remove(2, 3)
period.add(6, 8)
period.remove(4, 7)
period.add(2, 7)

p period.intervals.map(&:values)

period = Period.new

puts 'Please use either :add or :remove'
print '>>> '

begin
  while(input = gets.chomp)
    args = input.split(/\(|\)|,/)
    period.public_send(*args)

    p period.intervals.map(&:values)
    print '>>> '
  end
rescue Exception => e
  puts 'Goodbye!'
end
