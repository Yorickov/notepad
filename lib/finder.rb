class Finder
  def initialize(note, repository, _console_reader = nil)
    @note = note
    @repository = repository
  end

  def start
    puts 'Enter id to find note OR nothing to find all notes'
    id = STDIN.gets.chomp
    if id == ''
      notes = @repository.find_all(@note.class.name)
      return puts 'No such note' if notes.nil?

      puts notes
    else
      note = @repository.find_by_id(id, @note.class.name)
      return puts 'No such note' if note.nil?

      puts note
    end
  end
end
