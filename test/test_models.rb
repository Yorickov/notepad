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
    expected = [link.time_string, 'some text', 'some text']

    @console_reader.stub(:read_line, 'some text') do
      link.read_from_console(@console_reader)
      assert_equal(expected, link.to_array)
    end
  end

  def test_memo
    memo = Memo.new
    expected = [memo.time_string, 'some text']

    @console_reader.stub(:read_text, ['some text']) do
      memo.read_from_console(@console_reader)
      assert_equal(expected, memo.to_array)
    end
  end

  def test_task
    task = Task.new
    expected = ['Deadline: 12.05.2003', '12.05.2003', task.time_string]

    @console_reader.stub(:read_line, '12.05.2003') do
      task.read_from_console(@console_reader)
      assert_equal(expected, task.to_array)
    end
  end
end
