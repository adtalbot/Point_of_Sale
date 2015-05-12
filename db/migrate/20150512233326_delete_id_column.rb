class DeleteIdColumn < ActiveRecord::Migration
  def change
    remove_column(:products_purchases, :id, :serial)
  end
end
