require 'date'

class Note
  def initialize
    @created_at = Time.now
  end

  def self.types
    { 'Memo' => Memo, 'Task' => Task, 'Link' => Link }
  end

  def self.create(type = nil)
    return types[type].new if type

    type_index = input_index
    type = types.keys[type_index]

    types[type].new
  end

  def self.input_index
    types.keys.each_with_index do |type, index|
      puts 'Enter index' \
        "\t#{index}. #{type}"
    end

    choice = STDIN.gets.chomp.to_i
    choice.between?(0, types.size - 1) ? choice : input_index
  end

  def time_string
    "Created at: #{@created_at.strftime('%d.%m.%Y, %H:%M:%S')} \n"
  end

  def save_to_txt
    File.open(file_path, 'w') { |file| to_array.each { |string| file.puts(string) } }
  rescue RuntimeError => e
    abort e.message
  end

  def file_path
    dir = File.expand_path('../data', __dir__)
    name_part = @created_at.strftime('%Y-%m-%d_%H-%M-%S')

    "#{dir}/#{self.class.name}_#{name_part}.txt"
  end
end
