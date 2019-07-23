class ConsoleReader
  def read_line
    line = STDIN.gets.encode('UTF-8').chomp
    line == '' ? read_line : line
  end

  def read_text(acc = [])
    line = STDIN.gets.encode('UTF-8').chomp
    line.downcase == 'end' ? acc : read_text(acc << line)
  end
end
