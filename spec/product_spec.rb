require('spec_helper')

describe(Product) do
  describe(:not_purchased) do
    it("returns products that have not been purchased") do
      not_purchased_product1 = Product.create({:name => "old chair"})
      purchased_product2 = Product.create({:name => "old table", :purchase_id => 4})
      purchased_products = [purchased_product2]
      not_purchased_products = [not_purchased_product1]
      expect(Product.not_purchased()).to(eq(not_purchased_products))
    end
  end

  describe("#purchase") do
    it("tells which purchase it is under") do
      test_purchase = Purchase.create()
      test_product = Product.create({:name => "product", :purchase_id => test_purchase.id})
      expect(test_product.purchase()).to(eq(test_purchase))
    end
  end
end
