require 'rails_helper'

RSpec.describe ReservedProduct, type: :model do
  let!(:apple) { create(:reserved_product, name: 'りんご') }
  let!(:banana) { create(:reserved_product, name: 'ばなな') }
  let!(:grape) { create(:reserved_product, name: 'ぶどう') }

  describe '関連先がない' do
    before do
      create(:sale, reserved_product: apple, memo: 'fooさん - りんご - 1つめ')
      create(:sale, reserved_product: apple, memo: 'fooさん - りんご - 2つめ')

      create(:sale, reserved_product: apple, memo: 'barさん - りんご')

      create(:sale, reserved_product: grape, memo: 'bazさん - ぶどう')
    end

    it 'いずれの結果も同じになること' do
      actual_by_left_join = ReservedProduct.left_outer_joins(:sales).where(sales: { id: nil }).to_a
      actual_by_missing = ReservedProduct.where.missing(:sales).to_a
      actual_eager_load = ReservedProduct.eager_load(:sales).where(sales: { id: nil }).to_a
      actual_not_in = ReservedProduct.where.not(id: ReservedProduct.joins(:sales).select(:id)).to_a
      actual_not_exists = ReservedProduct.where('NOT EXISTS (:sales)',
                                                sales: Sale.where('reserved_products.id = sales.reserved_product_id'))
                                         .to_a
      actual_not_exists_with_arel = ReservedProduct.where(Sale.where('reserved_products.id = sales.reserved_product_id').arel.exists.not).to_a

      expect(actual_by_left_join).to eq(actual_by_missing)
                                       .and eq(actual_eager_load)
                                              .and eq(actual_not_in)
                                                     .and eq(actual_not_exists)
                                                            .and eq(actual_not_exists_with_arel)
    end
  end

  describe '条件付きの関連先がない' do
    let!(:foo) { create(:customer, name: 'foo') }
    let!(:bar) { create(:customer, name: 'bar') }
    let!(:baz) { create(:customer, name: 'baz') }

    before do
      create(:sale_by_customer, reserved_product: apple, customer: foo)
      create(:sale_by_customer, reserved_product: banana, customer: foo)
      create(:sale_by_customer, reserved_product: grape, customer: foo)

      create(:sale_by_customer, reserved_product: apple, customer: bar)
      create(:sale_by_customer, reserved_product: banana, customer: bar)

      create(:sale_by_customer, reserved_product: grape, customer: baz)
    end

    shared_examples 'いずれの結果も同じになること' do
      it do
        actual_by_scope = ReservedProduct.no_reservations_by(customer_id).to_a

        actual_not_in = ReservedProduct.where.not(id: ReservedProduct.joins(sale_by_customers: :customer)
                                                                     .where(sale_by_customers: { customer_id: customer_id })
                                                                     .select(:id))
                                       .to_a

        actual_not_exists = ReservedProduct
                              .where('NOT EXISTS (:sale_by_customers)',
                                     sale_by_customers: SaleByCustomer
                                                          .where('reserved_products.id = sale_by_customers.reserved_product_id')
                                                          .where(customer_id: customer_id))
                              .to_a

        actual_not_exists_with_arel = ReservedProduct
                                        .where(SaleByCustomer.where('reserved_products.id = sale_by_customers.reserved_product_id')
                                                             .where(customer_id: customer_id ).arel.exists.not)
                                        .to_a

        expect(actual_by_scope).to eq(actual_not_in).and eq(actual_not_exists).and eq(actual_not_exists_with_arel)
      end
    end

    context 'fooさんの予約がない' do
      let(:customer_id) { foo.id }

      it_behaves_like 'いずれの結果も同じになること'
    end

    context 'barさんの予約がない' do
      let(:customer_id) { bar.id }

      it_behaves_like 'いずれの結果も同じになること'
    end

    context 'bazさんの予約がない' do
      let(:customer_id) { baz.id }

      it_behaves_like 'いずれの結果も同じになること'
    end
  end
end