require "thor"
require "pry"

class Drink
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  # 以下3つは、ショートカットとしてあってもよい
  # 定数でもいいかも WATER = self.new('water', 100)
  def self.water
    self.new('water', 100)
  end

  def self.cola
    self.new('cola', 120)
  end

  def self.redbull
    self.new('redbull', 200)
  end
end

class VendingMachine
  attr_reader :total_money, :sale_amount, :stocks, :drinks
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @total_money = 0
    @sale_amount = 0
    @stocks = {}
    @stocks.default = 0 # こうしておくと値が存在しないときnilではなく0になる
    @drinks = {}

    store(Drink.cola, 5) # せっかく入れるメソッドがあるので使いましょう
    store(Drink.water, 5)
    store(Drink.redbull, 5)
  end

  def insert(money)
    if MONEY.include?(money)
      @total_money += money
    end
  end

  def buy(drink)
    @total_money -= drink.price
    @stocks[drink.name.to_sym] -= 1
    @sale_amount += drink.price
  end

  def return_money
    @total_money = 0
  end

  def enough_money?(drink) # お金が足りる
    @total_money >= drink.price
  end

  def in_stock?(drink) # 在庫がある
    @stocks[drink.name.to_sym] > 0
  end

  def purchasable?(drink)
    enough_money?(drink) && in_stock?(drink)
  end

  def purchasable_drink_list
    @drinks.each_value do |drink|
      if purchasable?(drink)
        puts "#{drink.name}を買えます"
      else
        puts "#{drink.name}を買えません"
      end
    end
  end

  def drink_stocks # 格納されているジュースの情報。customerではこれを使う
    @drinks.map do |key, drink|
      {drink: drink, stock: @stocks[key]}
    end
  end

  def store(drink, num)
    @stocks[drink.name.to_sym] += num
    @drinks[drink.name.to_sym] = drink # Drink自体もここで入れる
    # ただし、名前が同じで価格が違うDrinkを作ってしまうとおかしくなるので注意
  end

  def find_drink_by_index(index) # 番号からDrinkオブジェクトを探す
    @drinks.values[index]
  end

  def find_drink_by_name(name) # 名前からDrinkオブジェクトを探す
    @drinks[name.to_sym]
  end
end

