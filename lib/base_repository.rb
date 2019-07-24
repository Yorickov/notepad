class BaseRepository
  def initialize(db_path)
    @db_path = db_path
  end

  def save_to_txt(note)
    File.open(note.file_path, 'w') do |file|
      note.to_array.each { |string| file.puts(string) }
    end
  rescue RuntimeError => e
    abort e.message
  end

  def save_to_db(note)
    note_hash = note.to_hash

    model_name = note.class.name.downcase + 's'
    prepared_fields = note_hash.keys.join(', ')
    prepared_values = ('?, ' * note_hash.size).chomp(', ')

    sql = "INSERT INTO #{model_name} (#{prepared_fields}) VALUES (#{prepared_values})"

    query(sql, note_hash.values)
  end

  def query(sql, params)
    db = SQLite3::Database.open(@db_path)
    db.results_as_hash = true

    begin
      db.execute(sql, params)
    rescue SQLite3::SQLException => e
      puts "Failed query into #{@db_path}"
      abort e.message
    end

    last_id = db.last_insert_row_id
    db.close

    last_id
  end
end
