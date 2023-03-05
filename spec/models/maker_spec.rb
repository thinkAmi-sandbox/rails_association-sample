# == Schema Information
#
# Table name: makers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#
# Indexes
#
#  index_makers_on_country_id  (country_id)
#
# Foreign Keys
#
#  country_id  (country_id => countries.id)
#
require 'rails_helper'

RSpec.describe Maker, type: :model do
  describe 'eager_loadとwhereの確認' do
    context '隣のモデルとjoin' do
      it do
        actual = Maker.joins(:country)

        expect(actual.count).to eq(0)
      end
    end

    context '隣とその隣のモデルとjoin' do
      it do
        # plants: [:employees], でも同じ
        actual = Maker.joins(plants: :employees)

        expect(actual.count).to eq(0)
      end
    end

    context 'さらに隣のモデルとjoin' do
      it do
        actual = Maker.joins(reserved_products: [
          :sales,
          :shop,
          { sale_by_customers: { customer: :country }}
        ])

        expect(actual.count).to eq(0)
      end
    end

    context '一度にjoin' do
      it do
        actual = Maker.joins(
          :country,
          plants: :employees,
          reserved_products: [:sales, :shop, { sale_by_customers: { customer: :country }}]
        )

        expect(actual.count).to eq(0)
      end
    end

    context 'whereをハッシュ指定' do
      context '等号' do
        it do
          actual = Maker.where(id: 1)

          expect(actual.count).to eq(0)
        end
      end

      context '不等号' do
        before { create(:maker, id: 1) }

        context '大なり' do
          it do
            actual = Maker.where(id: ...1)

            expect(actual.count).to eq(0)
          end
        end

        context '大なりイコール' do
          it do
            actual = Maker.where(id: ..1)

            expect(actual.count).to eq(1)
          end
        end

        context '小なり' do
          it do
            actual = Maker.where(Maker.arel_table[:id].gt(1))

            expect(actual.count).to eq(0)
          end
        end

        context '小なりイコール' do
          context '..を使う' do
            it do
              actual = Maker.where(id: 1..)

              expect(actual.count).to eq(1)
            end
          end

          context '...を使う' do
            it do
              actual = Maker.where(id: 1...)

              expect(actual.count).to eq(1)
            end
          end
        end
      end

      context 'BETWEEN' do
        before do
          create(:maker, id: 1)
          create(:maker, id: 2)
        end

        context '.. を使うとBETWEENになる' do
          it do
            actual = Maker.where(id: 1..2)

            expect(actual.count).to eq(2)
          end
        end

        context '...を使うと >= と < になる' do
          it do
            actual = Maker.where(id: 1...2)

            expect(actual.count).to eq(1)
          end
        end
      end

      context 'IN' do
        before do
          create(:maker, id: 1)
          create(:maker, id: 2)
        end

        it do
          actual = Maker.where(id: [1, 2])

          expect(actual.count).to eq(2)
        end
      end

      context 'IS NULL' do
        before do
          create(:maker_with_country, id: 1)
          create(:maker, id: 2, country: nil)
        end

        it do
          actual = Maker.where(country: nil)

          expect(actual.count).to eq(1)
          expect(actual.last.id).to eq(2)
        end
      end

      context '外部キーのID' do
        before do
          country = create(:country, id: 2)
          create(:maker, id: 1, country: country)
        end

        context '外部キー列(***_id)を指定' do
          it do
            actual = Maker.where(country_id: 2)

            expect(actual.count).to eq(1)
          end
        end

        context '関連名を指定' do
          it do
            actual = Maker.where(country: 2)

            expect(actual.count).to eq(1)
          end
        end
      end

      context '関連先のテーブルの列を指定' do
        context '関連が単数形' do
          before do
            country = create(:country, name: '日本')
            create(:maker, country: country)
          end

          context '関連名を使う' do
            it do
              actual = Maker.joins(:country).where(country: { name: '日本' })

              expect(actual.count).to eq(1)
            end
          end

          context 'テーブル名を使う' do
            it do
              actual = Maker.joins(:country).where(countries: { name: '日本' })

              expect(actual.count).to eq(1)
            end
          end
        end

        context '関連が複数形' do
          before do
            maker = create(:maker)
            create(:plant, maker: maker, name: '北工場')
          end

          it do
            actual = Maker.joins(:plants).where(plants: { name: '北工場' })

            expect(actual.count).to eq(1)
          end
        end
      end

      context '複数のANDでつなぐ条件' do
        before { create(:maker, id: 1) }

        it do
          actual = Maker.where(id: 1, country: nil)

          expect(actual.count).to eq(1)
        end
      end

      context '否定形' do
        context '単体' do
          before { create(:maker_with_country, id: 1) }

          context '否定' do
            it do
              actual = Maker.where.not(id: 1)

              expect(actual.count).to eq(0)
            end
          end

          context 'NOT IN' do
            it do
              actual = Maker.where.not(id: [1, 2])

              expect(actual.count).to eq(0)
            end
          end

          context 'NOT NULL' do
            it do
              actual = Maker.where.not(country: nil)

              expect(actual.count).to eq(1)
            end
          end
        end

        context '複数' do
          before { create(:maker_with_country, id: 1) }

          context 'NANDな書き方: NOT(IN AND IS NULL)' do
            # 6.1の変更による
            # https://railsguides.jp/6_1_release_notes.html#active-record-%E4%B8%BB%E3%81%AA%E5%A4%89%E6%9B%B4
            it do
              actual = Maker.where.not(id: 2, country: nil)

              expect(actual.count).to eq(1)
            end
          end

          context 'NORな書き方: NOT IN AND IS NOT NULL' do
            it do
              actual = Maker.where.not(id: 2).where.not(country: nil)

              expect(actual.count).to eq(1)
            end
          end
        end
      end

      context 'joinsとwhereとwhere.notの組み合わせ' do
        it do
          actual = Maker.joins(
            :country,
            plants: :employees, # plants: [:employees], でも同じ
            reserved_products: [{ sale_by_customers: { customer: :country }}, :shop]
          ).where(
            id: [1, 2, 3],
            plants: { id: 4..6 },
            employees: { id: ...7 },
            reserved_products: { id: 8.. },
            sale_by_customers: { customer_id: 9 },
          ).where.not(
            customers: { country: [10, 11, 12] },
            countries: { name: nil },
          )

          expect(actual.count).to eq(0)
        end
      end
    end

    context 'whereでLIKEを使う' do
      before do
        create(:maker, name: '東')
        create(:maker, name: '西')
        create(:maker, name: '南')
        create(:maker, name: '北')
      end

      context '%という文字を渡す' do
        let(:keyword) { '%' }

        context 'サニタイズしない' do
          it '全件取得できる' do
            actual = Maker.where('name LIKE ?', "%#{keyword}%")
            # => SELECT COUNT(*) FROM "makers" WHERE (name LIKE '%%%')

            expect(actual.count).to eq(4)
          end
        end

        context 'sanitize_sql_arrayを使う' do
          it '全件取得できる' do
            actual = Maker.where(Maker.sanitize_sql_array(['name LIKE ?', "%#{keyword}%"]))
            # => SELECT COUNT(*) FROM "makers" WHERE (name LIKE '%%%')

            expect(actual.count).to eq(4)
          end
        end

        context 'sanitize_sql_likeを使う' do
          it '1件も取得できない' do
            actual = Maker.where('name LIKE ?', "%#{Maker.sanitize_sql_like(keyword)}%")
            # => SELECT COUNT(*) FROM "makers" WHERE (name LIKE '%\%%')

            expect(actual.count).to eq(0)
          end
        end
      end

      context '_という文字を渡す' do
        let(:keyword) { '_' }

        context 'サニタイズしない' do
          it '全件取得できる' do
            actual = Maker.where('name LIKE ?', "%#{keyword}%")
            # => SELECT COUNT(*) FROM "makers" WHERE (name LIKE '%_%')

            expect(actual.count).to eq(4)
          end
        end

        context 'sanitize_sql_arrayを使う' do
          it '全件取得できる' do
            actual = Maker.where(Maker.sanitize_sql_array(['name LIKE ?', "%#{keyword}%"]))
            # => SELECT COUNT(*) FROM "makers" WHERE (name LIKE '%_%')

            expect(actual.count).to eq(4)
          end
        end

        context 'sanitize_sql_likeを使う' do
          it '1件も取得できない' do
            actual = Maker.where('name LIKE ?', "%#{Maker.sanitize_sql_like(keyword)}%")
            # => SELECT COUNT(*) FROM "makers" WHERE (name LIKE '%\_%')

            expect(actual.count).to eq(0)
          end
        end
      end
    end
  end
end
