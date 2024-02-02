class Item

  attr_accessor :name, :type_of_product, :price, :amount_in_stock, :item_rating, :item_comment

  def initialize(name, type_of_item, price, amount_in_stock)
      @name = name
      @type_of_item = type_of_item
      @price = price
      @amount_in_stock = amount_in_stock
  end



end # Of class
