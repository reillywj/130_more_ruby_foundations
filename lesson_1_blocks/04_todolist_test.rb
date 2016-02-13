require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '03_todolist'

class TodoListTest < Minitest::Test

  def setup
    @list = TodoList.new('Things to Do')
    @first_todo = Todo.new('Work')
    @second_todo = Todo.new('Eat')
    @third_todo = Todo.new('Sleep')
    @list << @first_todo << @second_todo << @third_todo
  end

  def test_type_error_when_adding
    assert_raises(TypeError) { @list << "Wrong Type" }
  end

  def test_size
    assert_equal 3, @list.size
  end

  def test_first
    assert_equal @first_todo, @list.first
  end

  def test_last
    assert_equal @third_todo, @list.last
  end

  def test_item_at
    assert_equal @first_todo, @list.item_at(0)
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert_equal true, @first_todo.done?
  end

  def test_mark_undone_at
    @list.mark_done_at(1)
    @list.mark_undone_at(1)
    assert_equal false, @list.item_at(1).done?
  end

  def test_shift
    assert_equal @first_todo, @list.shift
    assert_equal 2, @list.size
  end

  def test_pop
    assert_equal @third_todo, @list.pop
    assert_equal 2, @list.size
  end

  def test_remove_at
    @list.remove_at(1)
    assert_includes @list, @first_todo
    assert_includes @list, @third_todo
    refute_includes @list, @second_todo
  end

  def test_done
    assert_equal false, @list.done?
    @list.done!
    assert_equal true, @list.done?
  end

  def test_mark_done
    @list.mark_done('Sleep')
    assert_equal true, @list.find_by_title('Sleep' ).done?
  end

  def test_mark_all_undone
    @list.done!.mark_all_undone
    assert_equal false, @list.done?
  end

  def test_all_done
    assert_equal TodoList.new(''), @list.all_done
    @list.done!
    assert_equal @list, @list.all_done
  end

  def test_all_not_done
    assert_equal @list, @list.all_not_done
    @list.done!
    assert_equal TodoList.new(''), @list.all_not_done
  end

  def test_to_s_1
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ----Things to Do----
    [ ] Work
    [ ] Eat
    [ ] Sleep
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    @first_todo.done!
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ----Things to Do----
    [X] Work
    [ ] Eat
    [ ] Sleep
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    @list.done!
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ----Things to Do----
    [X] Work
    [X] Eat
    [X] Sleep
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each_iterates
    @list.each { |todo| todo.done! }

    assert_equal true, @list.done?
  end

  def test_each_returns_original_object
    return_object = @list.each { |todo| todo.done! }

    assert_same @list, return_object
  end

  def test_select
    odd_todos = @list.select { |todo| todo.title.downcase =~ /e/ }
    assert_equal [@second_todo, @third_todo], odd_todos.todos
  end

  def test_todos
    assert_equal [@first_todo, @second_todo, @third_todo], @list.todos
  end

  def test_find_by_title
    assert_equal @second_todo, @list.find_by_title('Eat')
  end
end