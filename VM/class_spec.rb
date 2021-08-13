require_relative 'class'

describe Drink do
  example 'cola' do
    expect(Drink.cola.name).to eq 'cola'
    expect(Drink.cola.price).to eq 120
  end
  example 'water' do
    expect(Drink.water.name).to eq 'water'
    expect(Drink.water.price).to eq 100
  end
  example 'redbull' do
    expect(Drink.redbull.name).to eq 'redbull'
    expect(Drink.redbull.price).to eq 200
  end
end

describe VendingMachine do
  before do
    @vm = VendingMachine.new
    @cola = Drink.cola
    @water = Drink.water
    @redbull = Drink.redbull
  end
  example 'initialize' do
    expect(@vm.total_money).to eq 0
    expect(@vm.sale_amount).to eq 0
    expect(@vm.stocks[@cola.name.to_sym]).to eq 5
    expect(@vm.stocks[@water.name.to_sym]).to eq 5
    expect(@vm.stocks[@redbull.name.to_sym]).to eq 5
  end
  example 'insert(money)' do
    @vm.insert(100)
    expect(@vm.total_money).to eq 100
    @vm.insert(300)
    expect(@vm.total_money).to eq 100
  end
  example 'buy(drink)' do
    @vm.insert(100)
    expect(@vm.total_money).to eq 100
    @vm.buy(@water)
    expect(@vm.total_money).to eq 0
    expect(@vm.stocks[@water.name.to_sym]).to eq 4
    expect(@vm.sale_amount).to eq 100
  end
  example 'return_money' do
    @vm.insert(100)
    expect(@vm.total_money).to eq 100
    @vm.return_money
    expect(@vm.total_money).to eq 0
  end
  example 'purchasable?(drink)' do
    @vm.insert(100)
    expect(@vm.purchasable?(@cola)).to eq "cola:買えません"
    expect(@vm.purchasable?(@water)).to eq "water:5"
    expect(@vm.purchasable?(@redbull)).to eq "redbull:買えません"
    @vm.insert(100)
    expect(@vm.purchasable?(@redbull)).to eq "redbull:5"
  end
  example 'store(drink, num)' do
    expect(@vm.stocks[@cola.name.to_sym]).to eq 5
    @vm.store(@cola, 2)
    expect(@vm.stocks[@cola.name.to_sym]).to eq 7
  end
end