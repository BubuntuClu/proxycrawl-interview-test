class CreateTableForAmazonGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_goods do |t|
      t.string :rel_canonical
      t.json :meta_info
      t.json :general_info
      t.string :good_type

      t.timestamps
    end
  end
end
