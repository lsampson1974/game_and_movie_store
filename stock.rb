
require_relative "items"


class ItemTracker

    def initialize

      @items = []

    end

    #---------------------

    def main_menu

        picked_option = ""

        while picked_option != "e" do

            puts "Welcome to the item tracking system !!"
            puts " "
            puts "Choose by typing the number and pressing <ENTER>"
            puts " "
            puts "<1> Add a new item"
            puts "<2> Add a rating and comment to an item"
            puts "<3> List all items"
            puts "<4> Show rating and comment for specific item"
            puts "<e> Exit"
            puts " "
            print ">> "

            picked_option = gets.chomp

            case picked_option
                when "1"
                  add_new_item

                when "2"
                  add_rating_comment

                when "3"
                  list_items

                when "4"
                  get_rating_comment

                when "e"
                  puts "Bye for now !!"

            end # Of case block

        end # Of while loop

    end # Of method

    #---------------------

    def add_new_item

       puts " "
       puts "Enter the name of the item : "
       item_name = gets.chomp

       puts " "
       puts "Enter the type of item : "
       item_type = gets.chomp

       puts " "
       puts "Enter the price of the item : "
       item_price = gets.chomp

       puts " "
       puts "Enter the amount (in stock) of the item : "
       item_amount = gets.chomp

       item_to_be_added = Dish.new(name, type_of_item, price, amount_in_stock)

       @items << items_to_be_added

    end

    #---------------------

    def add_rating_comment

    end



end # Of class
