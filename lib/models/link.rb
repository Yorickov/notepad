class Link < Note
  def read_from_console(console_reader)
    puts 'Enter url:'
    @url = console_reader.read_line

    puts 'Enter description'
    @text = console_reader.read_line
  end

  def to_array
    [time_string, @url, @text]
  end

  def to_hash
    super.merge(text: @text, url: @url)
  end

  def read_from_db(data)
    super

    @url = data['url']
  end
end
