class CashRegister
  attr_accessor :total, :discount

  def initialize(discount = 0)
    @total = 0
    @discount = discount
    @items = {}
  end

  def items=(item)
    @items[item[:title]] = { :price => item[:price], :quantity => item[:quantity] } 
  end

  def items
    all_items = [] 
    @items.each do |key, value|
      (1..value[:quantity]).each do
        all_items << key
      end
    end
    all_items
  end

  def add_item(title, price, quantity = 1)
    self.items=({ :title => title, :price => price, :quantity => quantity })
    self.total=(price * quantity + self.total)
  end

  def apply_discount
    return_message = ""
    if (self.discount > 0) 
      self.total=(100 - self.discount) * self.total  / 100
      return_message = "After the discount, the total comes to $#{self.total}."
    else return_message = "There is no discount to apply." 
    end
    return_message
  end

  def void_last_transaction
    price = @items[@items.keys[-1]][:price]
    quantity = @items[@items.keys[-1]][:quantity]
    self.total=(self.total - price * quantity)
  end
end
