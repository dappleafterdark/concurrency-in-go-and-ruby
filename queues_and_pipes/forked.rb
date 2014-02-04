

reader, writer = IO.pipe

if child_pid = Process.fork

  5.times do |i|
    sleep rand(i) # simulate expense
    writer.puts i
    puts "#{i} produced"
  end

  Process.wait child_pid

else

  5.times do |i|
    value = reader.gets.chomp
    sleep rand(i/2) # simulate expense
    puts "consumed #{value}"
  end

end
