require 'rubygems'
require 'bundler/setup'

require 'sqlite3'

require_relative 'lib/models/note.rb'
require_relative 'lib/models/link.rb'
require_relative 'lib/models/memo.rb'
require_relative 'lib/models/task.rb'

require_relative 'lib/console_reader'
require_relative 'lib/base_repository'
require_relative 'lib/db_manager'
require_relative 'lib/init_db'
require_relative 'lib/saver'
require_relative 'lib/finder'

db_path = './db/notepad.sqlite'

init_db(db_path, DbManager.new)

console_reader = ConsoleReader.new
repository = BaseRepository.new(db_path)

new_note = Note.create
mode_class = new_note.choose_mode

app = mode_class.new(new_note, repository, console_reader)
app.start

# repository.save_to_txt(new_note)
