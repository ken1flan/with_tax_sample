RSpec.describe WithTax do
  describe '.attr_with_tax' do
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
    let(:execution_date) { '2020/04/18' }

    before { Timecop.freeze(Date.parse(execution_date)) }
    after { Timecop.return }

    describe 'メソッドの追加' do
      let(:sample_item) { klass.new('Sample Item', 123) }

      it '#price_with_taxが存在すること' do
        expect(sample_item).to respond_to(:price_with_tax).with(1).argument
      end

      it '#name_with_taxが存在しないこと' do
        expect(sample_item).not_to respond_to(:name_with_tax)
      end
    end

    describe '#price_with_tax' do
      describe '小数点以下の処理' do
        subject { sample_item.price_with_tax }

        let(:sample_item) { klass.new('Sample Item', price) }
        context 'price = 123のとき' do
          let(:price) { 123 }

          it '135.3->135(切り捨て)になること' do
            is_expected.to eq 135
          end
        end

        context 'price = 345のとき' do
          let(:price) { 345 }

          it '379.8->379(切り捨て)になること' do
            is_expected.to eq 379
          end
        end
      end

      describe '税率' do
        describe '実行日による変化' do
          subject { sample_item.price_with_tax }

          let(:sample_item) { klass.new('Sample Item', 123) }

          context '2019/10/01のとき' do
            let(:execution_date) { '2019/10/01' }

            it '10%になること' do
              is_expected.to eq 135
            end
          end

          context '2019/09/30のとき' do
            let(:execution_date) { '2019/09/30' }

            it '8%になること' do
              is_expected.to eq 132
            end
          end

          context '2014/04/01のとき' do
            let(:execution_date) { '2014/04/01' }

            it '8%になること' do
              is_expected.to eq 132
            end
          end

          context '2014/03/31のとき' do
            let(:execution_date) { '2014/03/31' }

            it '5%になること' do
              is_expected.to eq 129
            end
          end

          context '1997/04/01のとき' do
            let(:execution_date) { '1997/04/01' }

            it '5%になること' do
              is_expected.to eq 129
            end
          end

          context '1997/03/31のとき' do
            let(:execution_date) { '1997/03/31' }

            it '3%になること' do
              is_expected.to eq 126
            end
          end

          context '1989/04/01のとき' do
            let(:execution_date) { '1989/04/01' }

            it '3%になること' do
              is_expected.to eq 126
            end
          end

          context '1989/03/31のとき' do
            let(:execution_date) { '1989/03/31' }

            it '0%になること' do
              is_expected.to eq 123
            end
          end
        end

        describe 'パラメータによる変化' do
          subject { sample_item.price_with_tax(Date.parse(effective_date)) }

          let(:sample_item) { klass.new('Sample Item', 123) }

          context '2019/10/01のとき' do
            let(:effective_date) { '2019/10/01' }

            it '10%になること' do
              is_expected.to eq 135
            end
          end

          context '2019/09/30のとき' do
            let(:effective_date) { '2019/09/30' }

            it '8%になること' do
              is_expected.to eq 132
            end
          end

          context '2014/04/01のとき' do
            let(:effective_date) { '2014/04/01' }

            it '8%になること' do
              is_expected.to eq 132
            end
          end

          context '2014/03/31のとき' do
            let(:effective_date) { '2014/03/31' }

            it '5%になること' do
              is_expected.to eq 129
            end
          end

          context '1997/04/01のとき' do
            let(:effective_date) { '1997/04/01' }

            it '5%になること' do
              is_expected.to eq 129
            end
          end

          context '1997/03/31のとき' do
            let(:effective_date) { '1997/03/31' }

            it '3%になること' do
              is_expected.to eq 126
            end
          end

          context '1989/04/01のとき' do
            let(:effective_date) { '1989/04/01' }

            it '3%になること' do
              is_expected.to eq 126
            end
          end

          context '1989/03/31のとき' do
            let(:effective_date) { '1989/03/31' }

            it '0%になること' do
              is_expected.to eq 123
            end
          end
        end
      end
    end
  end
end
