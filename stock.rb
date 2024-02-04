
require_relative "items"


class Stockroom

    def initialize

        @items = []
        @total_sold_value = 0
        @first_run = "yes"

    end

    #---------------------

    def main_menu

        picked_option = ""

        while picked_option != "e" do

            if @first_run == "yes"
                puts "Welcome to the item tracking system !!"
                puts " "
                puts "Choose by typing the number and pressing <ENTER>"
                @first_run = "no"
            end # Of first run check
            
            puts " "
            puts "<1> Add a new item"
            puts "<2> Add a rating and comment to an item"
            puts "<3> List all items"
            puts "<4> Show ratings and comments for a specific item"
            puts "<5> Sell items"
            puts "<6> Replenish items"
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

                when "6"
                  replenish_items

                when "e"
                  puts "Bye for now !!"
                  break
                else
                  puts "Invalid choice. Please choose one of (1-6) or e"
                  
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
       output_string = "Item".ljust(20)+"Quantity".ljust(20)+"Type".ljust(20)+"Rating"
       puts output_string
       puts " "
              
       if !self.is_stock_empty

          @items.each do |individual_item|

              stock_string = ""
              avg_rating_string = ""

              if individual_item.amount_in_stock > 0
                  stock_string = individual_item.amount_in_stock.to_s

              else
                  stock_string = "Out of stock."

              end # Of in stock check...



              avg = average_rating(individual_item.item_rating)

              if avg > 0
                  avg_rating_string = "* "*avg
              
              else
                  avg_rating_string = "No rating"                
              
              end # Of average rating check
                                    
              puts "#{individual_item.name}".ljust(20)+"#{stock_string}".ljust(20)+"#{individual_item.type_of_item}".ljust(20)+"#{avg_rating_string}"
               

           end # Of loop.

        else
           puts " "
           puts "No items found."   
           puts " "

        end # Of condition

        puts " "

    end # Of method.


    #---------------------

    def add_rating_comment

      list_items
      
      if !is_stock_empty

          puts "Which item would you like to add a rating to ?"
          puts "Choose (1 - #{@items.length})"
          print ">> "
          choice_num = gets.chomp

          while choice_num < 0 || choice_num > @items.length
              puts "Please choose again."
              puts "The choices are (1- #{@items.length})"
              choice_num = gets.chomp.to_i
          end # Of input check


          puts "You are adding a rating to #{@items[choice_num.to_i-1].name}"

          puts "Add your personal rating (1-5)"
          print ">> "
          personal_rating = gets.chomp

          while personal_rating.to_i > 5 || personal_rating.to_i < 0

              puts "Please choose 1-5 only"
              print ">> "
              personal_rating = gets.chomp

          end # Of valid input check loop.

          @items[choice_num.to_i-1].item_rating << personal_rating
      
          puts "Add a comment :"
          print ">> "
          personal_comment = gets.chomp

          @items[choice_num.to_i-1].item_comment << personal_comment

          puts " "

      else
        puts "There's nothing to add a rating to"
        puts " "
        puts "Press <ENTER> to continue..."
        gets.chomp

      end # Of condition 

    end # Of method

    #---------------------

    def get_rating_comment

      list_items

      if !is_stock_empty
          puts "Which item would you like to view the ratings and comments ?"
          puts "Choose (1 - #{@items.length})"
          print ">> "
          choice_num = gets.chomp.to_i
          puts " "

          while choice_num < 0 || choice_num > @items.length
              puts "Please choose again."
              puts "The choices are (1- #{@items.length})"
              choice_num = gets.chomp.to_i
          end # Of input check

          output_name = @items[choice_num-1].name
          output_type = @items[choice_num-1].type_of_item
          item_rating_list = @items[choice_num-1].item_rating

          avg = average_rating(item_rating_list)
          avg_rating_string = ""

          if avg > 0
              avg_rating_string = "* "*avg          
          else
              avg_rating_string = "No rating"
          end # Of average rating check


          comment_list = @items[choice_num-1].item_comment

          puts "Item name : #{output_name}"
          puts "Type of item : #{output_type}"
          puts "Rating : #{avg_rating_string}"

          if comment_list.length == 0
              puts " "
              puts "There are no comments for this item."

          else
             comment_list.each do |comment|

                 puts " "
                 puts "------------------------------"
                 puts "#{comment}"
                 puts "------------------------------" 
                 puts " "

             end # Of comment print loop.

          end # Of comment list check


      else
          puts "There's no items with ratings to view"
          puts " "
          puts "Press <ENTER> to continue..."
          gets.chomp

      end # Of condition 

    end # Of method
    
    #---------------------

    def sell_items

        if is_stock_empty
            puts "There are no items to sell"
            
        else
            list_items

            puts "Which item would you like to sell? (1- #{@items.length}) or <e> to exit"
            print ">> "
            
            choice_made = gets.chomp

            if choice_made != "e"
                choice_num = choice_made.to_i
            else 
                return
            end

            while choice_num < 0 || choice_num > @items.length
                puts "Please choose again."
                puts "The choices are (1- #{@items.length}) or <e> to exit"

                choice_made = gets.chomp

                if choice_made != "e"
                    choice_num = choice_made.to_i
                else 
                    return
                end
    
            end # Of input check

            amount_of_item = @items[choice_num-1].amount_in_stock
            price_per_item = @items[choice_num-1].price

            puts "How much ?"
            print ">> "
            quantity = gets.chomp.to_i

            while quantity < 1 || quantity > amount_of_item
                puts " "
                puts "Please choose again."
                puts "Choose a number between 1 and #{amount_of_item}"
                print ">> "
                quantity = gets.chomp.to_i
            end

            # Calculate price and adjust quantity for amount sold.

            puts " "
            puts "Total sold : #{quantity} @ #{price_per_item}"

            @items[choice_num-1].amount_in_stock -= quantity

            amount_made = quantity*price_per_item

            puts " "
            puts "Amount made : #{amount_made}"

            @total_sold_value += amount_made

            puts "Grand total (from all sold items) : #{@total_sold_value}"
          

        end # Of stock check condition.


    end # of method

    #---------------------
  
    def replenish_items

        if is_stock_empty
            puts "There are no items to replenish"
            
        else
            list_items

            puts "Which item would you like to replenish? (1- #{@items.length}) or <e> to exit"
            print ">> "
            
            choice_made = gets.chomp

            if choice_made != "e"
                choice_num = choice_made.to_i
            else 
                return
            end

            while choice_num < 0 || choice_num > @items.length
                puts "Please choose again."
                puts "The choices are (1- #{@items.length}) or <e> to exit"

                choice_made = gets.chomp

                if choice_made != "e"
                    choice_num = choice_made.to_i
                else 
                    return
                end
    
            end # Of input check

            amount_of_item = @items[choice_num-1].amount_in_stock

            puts " "
            puts "How much to add ?"
            print ">> "
            additional_stock = gets.chomp.to_i

            @items[choice_num-1].amount_in_stock = amount_of_item+additional_stock

            puts " "
            puts "Item amount updated..."
            puts " "

        end # Of stock check.


    end # Of method



    #-------------------------------------------------
    #-------------------------------------------------
    # Helper methods :

    def list_items

      if !self.is_stock_empty
          puts "Items in stock :"
          puts "----------------"
          puts " "  

          output_string = ""

          item_counter = 0
          @items.each do |individual_item|

              if individual_item.amount_in_stock > 0
                  output_string = "<#{item_counter+1}> #{individual_item.name} (#{individual_item.amount_in_stock})"

              else
                  output_string = "<#{item_counter+1}> #{individual_item.name} (Not in stock)"

              end # Of stock check.

              puts output_string 
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

          running_total += rating.to_i

       end # Of loop

       if running_total == 0
          average = 0

       else   
          average = running_total/item_rating_list.length
          average = average.round()

       end # Of condition block.

       average
       

    end # Of method

end # Of class
