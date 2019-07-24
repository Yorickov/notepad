require 'rubygems'
require 'bundler/setup'

require 'sqlite3'

require_relative 'lib/note.rb'
require_relative 'lib/link.rb'
require_relative 'lib/memo.rb'
require_relative 'lib/task.rb'
require_relative 'lib/console_reader.rb'
require_relative 'lib/base_repository'
require_relative 'lib/db_manager'

db_path = './db/notepad.sqlite'

db_manager = DbManager.new

begin
  db_manager.create_table(
    db_path,
    'links',
    created_at: 'datetime',
    text: 'text',
    url: 'text'
  )
rescue SQLite3::SQLException => e
  puts "Failed create db on #{@db_path}"
  abort e.message
end

console_reader = ConsoleReader.new
repository = BaseRepository.new(db_path)

new_note = Note.create
new_note.read_from_console(console_reader)
puts repository.save_to_db(new_note)

# repository.save_to_txt(new_note)

puts 'Done!'
