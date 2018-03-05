# require("spec_helper")
# require("pry")
#
# describe(Brand) do
#   it("lists all brands") do
#     brand1 = Brand.create({name: "Nike", price: "50"})
#     brand2 = Brand.create({name: "Mike", price: "50"})
#     expect(Brand.all).to(eq([brand1, brand2]))
#   end
#
#   it("has many stores") do
#     brand = Brand.create({name: "Nike", price: "50"})
#     store1 = Store.create({name: "Payless"})
#     store2 = Store.create({name: "Sears"})
#     brand.stores.push(store1)
#     brand.stores.push(store2)
#     expect(brand.stores).to(eq([store1, store2]))
#   end
#
#   it("capitalizes name") do
#     brand = Brand.create({name: "nike", price: "50"})
#     expect(brand.name).to(eq("Nike"))
#   end
#
#   it("converts price to currency format") do
#     brand1 = Brand.create({name: "Nike", price: "50"})
#     brand2 = Brand.create({name: "Mike", price: "50.001"})
#     expect(brand1.price).to(eq("$50.00"))
#     expect(brand2.price).to(eq("$50.00"))
#   end
#
#   it("doesn't save blank names") do
#     brand1 = Brand.new({name: "Nike", price: "50"})
#     brand2 = Brand.new({price: "50"})
#     expect(brand1.save).to(eq(true))
#     expect(brand2.save).to(eq(false))
#   end
#
#   it("doesn't save duplicate names") do
#     brand1 = Brand.new({name: "Nike", price: "50"})
#     brand2 = Brand.new({name: "Nike", price: "50"})
#     expect(brand1.save).to(eq(true))
#     expect(brand2.save).to(eq(false))
#   end
#
#   it("doesn't save names over 100 characters") do
#     brand = Brand.new({name: "a;kljfhalsdkfjhalsfjkhalskfjhalskfjhalskfjhalskdjfhalkfjdhalskfjhlasdkfjhalskdfjhalksfjhalskdfjhalskdfjhalskfjhaslkdfjhalksdfjhalskfjhalskdfjhalskfdjhalskdfjhasldkfjhasldkfjhalsdkfjhalsdkfjhasldfkjhalsdfkjhalsdkfh", price: "50"})
#     expect(brand.save).to(eq(false))
#   end
# end
