require 'with_tax'

RSpec.describe WithTax do
  describe '.attr_with_tax' do
    let(:sample_item) { klass.new(123) }
    let(:klass) do
      Class.new do
        extend WithTax

        attr_accessor :name, :price
        attr_with_tax :price

        def initialize(name, price)
          @price = price
        end
      end
    end

    it '#price_with_taxが存在すること' do
      expect(sample_item).to respond_to(:price_with_tax).with(1).argument
    end

    it '#name_with_taxが存在しないこと' do
      expect(sample_item).not_to respond_to(:name_with_tax)
    end
  end
end
