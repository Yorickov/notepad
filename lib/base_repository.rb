class BaseRepository
  def save_to_txt(note)
    File.open(note.file_path, 'w') do |file|
      note.to_array.each { |string| file.puts(string) }
    end
  rescue RuntimeError => e
    abort e.message
  end
end
