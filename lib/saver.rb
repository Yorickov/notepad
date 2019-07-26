class Saver
  def initialize(note, repository, console_reader)
    @note = note
    @repository = repository
    @console_reader = console_reader
  end

  def start
    @note.read_from_console(@console_reader)
    id = @repository.save_to_db(@note)
    puts "Note saved, id = #{id}"
  end
end
