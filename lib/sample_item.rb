class SampleItem
  extend WithTax

  attr_accessor :price
  attr_with_tax :price

  def initialize(price)
    @price = price
  end
end
