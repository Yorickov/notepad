class Memo < Note
  def read_from_console(console_reader)
    puts 'Put down note (enter END to finish):'

    @text = console_reader.read_text
  end

  def to_array
    [time_string] + @text
  end

  def to_hash
    super.merge(text: @text.join('\n'))
  end
end
