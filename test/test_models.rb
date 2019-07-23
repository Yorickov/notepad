require 'minitest/autorun'

require 'note'
require 'link'
require 'memo'
require 'task'
require 'console_reader'

class TestModels < Minitest::Test
  def setup
    @console_reader = ConsoleReader.new
  end

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
      link.save_to_txt
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
      memo.save_to_txt
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
      task.save_to_txt
      file_content = File.read(path)
      assert(file_content.include?('Deadline: 12.05.2003'))
    end
  end
end
