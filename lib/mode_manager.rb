class ModeManager
  def initialize(note, repository, console_reader)
    @note = note
    @repository = repository
    @console_reader = console_reader
  end

  def self.modes
    { 'create' => Saver, 'find' => Finder }
  end

  def self.choose_mode
    puts 'Enter mode - create note or find'

    modes.keys.each_with_index do |action, index|
      puts 'Enter index' \
        "\t#{index}. #{action}"
    end

    choose_index = STDIN.gets.chomp.to_i
    index = choose_index.between?(0, modes.size - 1) ? choose_index : choose_mode
    mode = modes.keys[index]

    modes[mode]
  end
end
