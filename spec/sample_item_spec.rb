RSpec.describe SampleItem do
  describe '#price_with_tax' do
    subject { SampleItem.new('Sample Item', 123) }

    it '#price_with_taxが利用できること' do
      is_expected.to respond_to(:price_with_tax).with(1).argument
    end
  end
end
