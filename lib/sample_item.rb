class SampleItem
  extend WithTax

  attr_accessor :name, :price
  attr_with_tax :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
