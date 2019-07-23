require 'rubygems'
require 'bundler/setup'

require 'sqlite3'

require_relative 'lib/note.rb'
require_relative 'lib/link.rb'
require_relative 'lib/memo.rb'
require_relative 'lib/task.rb'
require_relative 'lib/console_reader.rb'

console_reader = ConsoleReader.new

new_note = Note.create

new_note.read_from_console(console_reader)

new_note.save_to_txt

puts 'Done!'
