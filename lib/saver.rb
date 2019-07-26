class Saver < ModeManager
  def start
    @note.read_from_console(@console_reader)
    @repository.save_to_db(@note)

    puts 'Note saved'
  end
end
