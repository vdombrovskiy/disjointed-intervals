require './environment'

puts 'Examples of usage: add(1, 5) or remove(2, 3)'

period = Period.new

p "Call: add(1, 5) => #{period.add(1, 5)}"
p "Call: remove(2, 3) => #{period.remove(2, 3)}"
p "Call: add(6, 8) => #{period.add(6, 8)}"
p "Call: remove(4, 7) => #{period.remove(4, 7)}"
p "Call: add(2, 7) => #{period.add(2, 7)}"

print '>>> '

begin
  period = Period.new
  while(input = gets.chomp)
    args = input.split(/\(|\)|,/)
    period.public_send(*args)

    p period.intervals.map(&:values)
    print '>>> '
  end
rescue Exception => e
  puts 'Goodbye!'
end
