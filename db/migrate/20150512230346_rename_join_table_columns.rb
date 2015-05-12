class RenameJoinTableColumns < ActiveRecord::Migration
  def change
    remove_column(:products_purchases, :products_id, :integer)
    remove_column(:products_purchases, :purchases_id, :integer)

    add_column(:products_purchases, :product_id, :integer)
    add_column(:products_purchases, :purchase_id, :integer)
  end
end
