class Item

  attr_accessor :name, :type_of_item, :price, :amount_in_stock, :item_rating, :item_comment

  def initialize(name, type_of_item, price, amount_in_stock)
      @name = name
      @type_of_item = type_of_item
      @price = price.to_i
      @amount_in_stock = amount_in_stock.to_i

      @item_rating = []
      @item_comment = []
  end



end # Of class
