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
    @stocks.default = 0
    @drinks = {}

    store(Drink.cola, 5)
    store(Drink.water, 5)
    store(Drink.redbull, 5)
  end

  def insert(money) #C-14
    if MONEY.include?(money)
      @total_money += money
    end
  end

  def buy(drink) #C-20
    @total_money -= drink.price
    @stocks[drink.name.to_sym] -= 1

    @sale_amount += drink.price
  end

  def return_money
    @total_money = 0
  end

  def enough_money?(drink)
    @total_money >= drink.price
  end

  def in_stock?(drink)
    @stocks[drink.name.to_sym] > 0

  end

  def purchasable?(drink)
    enough_money?(drink) && in_stock?(drink) #K-59~64
    # binding.irb

  end

  def purchasable_drink_list
    @drinks.each_value do |drink|
      if purchasable?(drink) #K-64~68
        puts "#{drink.name}を買えます"

      else
        puts "#{drink.name}を買えません"
      end
    end
  end

  def store(drink, num)
    @stocks[drink.name.to_sym] += num
    @drinks[drink.name.to_sym] = drink
  end

  def find_drink_by_index(index)
    @drinks.values[index]
  end

  def find_drink_by_name(name) # 名前からDrinkオブジェクトを探す
    @drinks[name.to_sym]
  end
end

def buy_process(number)
  drink = @vm.find_drink_by_index(number - 1) #K-90~92
  if @vm.total_money < drink.price #AK-45
    puts "お金が足りません"
    exit
  elsif @vm.stocks[drink.name.to_sym] == 0 #AK-38
    puts "#{drink.name}の在庫がありません"
    exit
  else
    @vm.buy(drink) #K-49~53
    puts 'ガチャン！コーラをお買い上げいただきありがとうございます'
    puts "残り#{@vm.total_money}円分購入可能です"
  end
end

def insert_money_process
  puts 'お金を入れてください'
  money = gets.to_i
  unless MONEY.include?(money)
    puts "#{money}円はこの自動販機では利用できません"
    exit
  else
    @vm.insert(money) #K-44~48
    puts "#{money}円自動販売機に入れました"
  end
end
