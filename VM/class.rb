require "thor"
require "pry"

class Drink
  attr_reader :name, :price
  def initialize(name, price, count)
    @name = name
    @price = price
    @count = count
  end

  def purchasable?(money)
    money >= self.price && @count > 0
  end

  #
  # def self.water
  #   self.new( 'water',100 )
  # end
  #
  # def self.cola
  #   self.new( 'cola', 120 )
  # end
  #
  # def self.redbull
  #   self.new( 'redbull', 200)
  # end
end

class VendingMachine
  attr_reader :total_money, :sale_amount, :stocks, :error_message
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @total_money = 0
    @sale_amount = 0
    # @stocks = {cola: 5, water: 5, redbull: 5}
    @stocks = []
    @stocks << Drink.new( 'water',100, count: 5)
    @stocks << Drink.new( 'cola', 120, count: 5)
    @stocks << Drink.new( 'redbull', 200, count: 5)
  end

  def insert(money)
    if MONEY.include?(money)
      @total_money += money
    end
  end

  # def buy(drink)
  #   @total_money -= drink.price
  #   @stocks[drink.name.to_sym] -= 1
  #   @sale_amount += drink.price
  # end

  def return_money
    @total_money = 0
  end

  # vending machine側は、文字出力すると使う側でコントロールできないので、情報だけ返してあげるようにしたほうが自然
  # def purchasable?(drink)
  #   if @total_money >= drink.price && @stocks[drink.name.to_sym] > 0
  #     "#{drink.name}:#{@stocks[drink.name.to_sym]}"
  #   else
  #     "#{drink.name}:買えません"
  #   end
  # end

  def drink_list
    # Drink全体を持っている入れ物がほしい
    # [Drink.cola, Drink.water, Drink.redbull].each do |drink|
    @stocks.each.with_index(1) do |drink, index|
      { id: index, name: drink.name, price: drink.price, purchasable: purchasable?(@total_money)}
    end
    # puts (purchasable?(Drink.cola))
    # puts (purchasable?(Drink.water))
    # puts (purchasable?(Drink.redbull))
  end

  def store(drink, num)
    @stocks[drink.name.to_sym] += num
  end

  def drink_info(drink_id)
    @stocks[drink_id - 1]
  end

  def buy(drink_id)
    drink = drink_info(drink_id)

    if @total_money < drink.price
      @error_message = 'お金が足りません'
      return false
    end

    if drink.count <= 0
      @error_message = "#{drink.name}の在庫がありません"
      return false
    end

    @total_money -= drink.price
    drink.count -= 1
    @sale_amount += drink.price

    true
  end
end
