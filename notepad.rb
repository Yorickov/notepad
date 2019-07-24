require 'rubygems'
require 'bundler/setup'

require 'sqlite3'

require_relative 'lib/models/note.rb'
require_relative 'lib/models/link.rb'
require_relative 'lib/models/memo.rb'
require_relative 'lib/models/task.rb'

require_relative 'lib/console_reader.rb'
require_relative 'lib/base_repository'
require_relative 'lib/db_manager'
require_relative 'lib/init_db'

db_path = './db/notepad.sqlite'

init_db(db_path, DbManager.new)

console_reader = ConsoleReader.new

repository = BaseRepository.new(db_path)

new_note = Note.create
new_note.read_from_console(console_reader)

puts repository.save_to_db(new_note)

# repository.save_to_txt(new_note)

puts 'Done!'
