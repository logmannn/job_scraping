require("spec_helper")
require("pry")

describe(Store) do
  it("lists all stores") do
    store1 = Store.create({name: "Payless"})
    store2 = Store.create({name: "Sears"})
    expect(Store.all).to(eq([store1, store2]))
  end

  it("has many brands") do
    store = Store.create({name: "Payless"})
    brand1 = Brand.create({name: "Nike", price: "50"})
    brand2 = Brand.create({name: "Mike", price: "50"})
    store.brands.push(brand1)
    store.brands.push(brand2)
    expect(store.brands).to(eq([brand1, brand2]))
  end

  it("capitalizes name") do
    store = Store.create({name: "payless"})
    expect(store.name).to(eq("Payless"))
  end

  it("doesn't save blank names") do
    store1 = Store.new({name: "Payless"})
    store2 = Store.new()
    expect(store1.save).to(eq(true))
    expect(store2.save).to(eq(false))
  end

  it("doesn't save duplicate names") do
    store1 = Store.new({name: "Payless"})
    store2 = Store.new({name: "Payless"})
    expect(store1.save).to(eq(true))
    expect(store2.save).to(eq(false))
  end

  it("doesn't save names over 100 characters") do
    store = Store.new({name: "a;kljfhalsdkfjhalsfjkhalskfjhalskfjhalskfjhalskdjfhalkfjdhalskfjhlasdkfjhalskdfjhalksfjhalskdfjhalskdfjhalskfjhaslkdfjhalksdfjhalskfjhalskdfjhalskfdjhalskdfjhasldkfjhasldkfjhalsdkfjhalsdkfjhasldfkjhalsdfkjhalsdkfh"})
    expect(store.save).to(eq(false))
  end
end
