require 'date'

class Task < Note
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console(console_reader)
    puts 'Enter task'
    @text = console_reader.read_line

    puts 'Enter deadline in format DD.MM.YYYY, ' \
      'for example: 12.05.2003'
    input = console_reader.read_line

    begin
      @due_date = Date.parse(input)
    rescue ArgumentError => e
      puts e.message + ' try another'
      read_from_console
    end
  end

  def to_array
    deadline = "Deadline: #{@due_date.strftime('%d.%m.%Y')}"

    [deadline, @text, time_string]
  end
end
