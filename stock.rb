
require_relative "items"


class Stockroom

    def initialize

        @items = []
        @total_sold_value = 0

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
            puts "<4> Show ratings and comments for a specific item"
            puts "<5> Sell items"
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
                  list_all_items

                when "4"
                  get_rating_comment

                when "5"
                  sell_items

                when "e"
                  puts "Bye for now !!"
                  break
                else
                  puts "Invalid choice. Please choose one of (1-5) or e"
                  
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
       amount_in_stock = gets.chomp

       item_to_be_added = Item.new(item_name, item_type, item_price, amount_in_stock)

       @items << item_to_be_added

       puts "Item added..."

       puts " "

    end

    #---------------------

    def list_all_items

       puts "Currently stored items :"
       puts "------------------------"
       puts " "
       puts "Item              Quantity        Rating"
              
       if !self.is_stock_empty

          @items.each do |individual_item|

              if indivdual_item.amount_in_stock > 0

                  avg = average_rating(individual_item.item_rating)
                  puts "#{individual_item.name}              #{individual_item.amount_in_stock}        #{avg}" 

              else
                  puts "#{individual_item.name}              Out Of Stock        #{avg}" 
                                    

              end # Of condition
           


           end # Of loop.

        else
           puts "No items found."   

    end # Of condition



    end


    #---------------------

    def add_rating_comment

      list_items
      
      if !is_stock_empty

          puts "Which item would you like to add a rating to ?"
          puts "Choose (1 - #{@items.length})"
          print ">> "
          choice_num = gets.chomp

          puts "You are adding a rating to #{@items[choice_num.to_i-1].name}"

          puts "Add your personal rating (1-5)"
          print ">> "
          personal_rating = gets.chomp

          while personal_rating.to_i > 5

              puts "Please choose 1-5 only"
              print ">> "
              personal_rating = gets.chomp

          end # Of valid input check loop.

          @items[choice_num.to_i-1].item_rating << personal_rating
      
          puts "Add a comment :"
          print ">> "
          personal_comment = gets.chomp

          @items[choice_num.to_i-1].item_comment << personal_rating

          puts " "

      else
        puts "Press <ENTER> to continue..."
        gets.chomp

      end # Of condition 

    end

    #---------------------

    def list_items

      if !self.is_stock_empty
          puts "Items in stock :"
          puts "----------------"
          puts " "  

          item_counter = 0
          @items.each do |individual_item|

              puts "<#{item_counter+1}> #{individual_item.name}" 
              item_counter += 1

          end # Of loop.

      else
        puts "No items found."   

      end # Of condition

    end
    
    #---------------------

    def is_stock_empty

        @items.empty?

    end

    #---------------------

    def average_rating(item_rating_list)

       running_total = 0

       item_rating_list.each do |rating|

          running_total += rating

       end

       average = running_total/item_rating_list.length

       average.round()

    end

end # Of class
