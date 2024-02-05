require 'minitest/autorun'
require './inventory'

class TestInventoryTracker < Minitest::Test

  def setup
    @stockroom_test = Stockroom.new
  end


  def test_input_checker

    first_menu_number = 1

    last_menu_number = 5

    user_input = 7

    assert_equal false, @stockroom_test.input_ok(first_menu_number, last_menu_number, user_input), "Input check method failed"


  end # Of test input checker.


#-----------------------------

  def test_empty_inventory_check

    assert_output(/No items found./) {@stockroom_test.list_items}

  end
    
#-----------------------------

  def test_insert_new_item

      assert_output(/Item added.../) { @stockroom_test.add_item("R-Type", "game", "40", "10") }

  end

  
#-----------------------------

  def test_rating_string

    test_rating_array = [4, 4, 1, 3]

    assert_equal "* * * ", @stockroom_test.get_average_rating_string(test_rating_array), "Method failed to create rating string."

  end


end # End of class.
