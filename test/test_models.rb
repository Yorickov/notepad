require 'minitest/autorun'
require 'rubygems'
require 'bundler/setup'
require 'sqlite3'

require 'models/note'
require 'models/link'
require 'models/memo'
require 'models/task'
require 'console_reader'
require 'repository'
require 'db_manager'
require 'init_db'

class TestModels < Minitest::Test
  def setup
    @console_reader = ConsoleReader.new
    @repository = Repository.new('test/tmp/memory')

    # init_db('test/tmp/memory', DbManager.new)
  end

  # def teardown
  #   SQLite3::Database.open('test/tmp/memory') do |db|
  #     db.execute('DROP TABLE IF EXISTS links')
  #     db.execute('DROP TABLE IF EXISTS memos')
  #     db.execute('DROP TABLE IF EXISTS tasks')
  #   end
  # end

  def test_note
    instance = Note.create('Link')
    assert_equal('Link', instance.class.name)

    Note.stub(:input_index, 1) do
      instance = Note.create
      assert_equal('Task', instance.class.name)
    end
  end

  def test_link
    link = Link.new
    path = __dir__ + '/tmp/link.txt'

    @console_reader.stub(:read_line, 'some link') do
      link.read_from_console(@console_reader)
      expected = [link.time_string, 'some link', 'some link']
      assert_equal(expected, link.to_array)
    end

    link.stub(:file_path, path) do
      @repository.save_to_txt(link)
      file_content = File.read(path)
      assert(file_content.include?('some link'))
    end
  end

  def test_memo
    memo = Memo.new
    path = __dir__ + '/tmp/memo.txt'

    @console_reader.stub(:read_text, ['some memo']) do
      memo.read_from_console(@console_reader)
      expected = [memo.time_string, 'some memo']
      assert_equal(expected, memo.to_array)
    end

    memo.stub(:file_path, path) do
      @repository.save_to_txt(memo)
      file_content = File.read(path)
      assert(file_content.include?('some memo'))
    end
  end

  def test_task
    task = Task.new
    path = __dir__ + '/tmp/task.txt'

    @console_reader.stub(:read_line, '12.05.2003') do
      task.read_from_console(@console_reader)
      expected = ['Deadline: 12.05.2003', '12.05.2003', task.time_string]
      assert_equal(expected, task.to_array)
    end

    task.stub(:file_path, path) do
      @repository.save_to_txt(task)
      file_content = File.read(path)
      assert(file_content.include?('Deadline: 12.05.2003'))
    end

    # last_id = @repository.save_to_db(task)
    # assert_equal(1, last_id)
  end
end
