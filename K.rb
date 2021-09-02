class Drink
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  # 以下3つは、ショートカットとしてあってもよい
  # 定数でもいいかも WATER = self.new('water', 100)
  def self.water
    self.new('ウォーター', 100)
  end

  def self.cola
    self.new('コーラ', 120)
  end

  def self.redbull
    self.new('レッドブル', 200)
  end
end

class VendingMachine
  attr_reader :total_money, :sale_amount, :stocks, :drinks
  # MONEY = [10, 50, 100, 500, 1000].freeze
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

  def insert(money) #C-13
    if MONEY.include?(money)
      @total_money += money
    end
  end

  def buy(drink) #C-20
    @total_money -= drink.price
    @stocks[drink.name] -= 1 

    @sale_amount += drink.price
  end

  def return_money #担当おつり
    @total_money = 0
  end

  def enough_money?(drink) #残金
    @total_money >= drink.price #投入金額
  end

  def in_stock?(drink)
    @stocks[drink.name] > 0

  end #K70~79

  def purchasable?(drink)
    enough_money?(drink) && in_stock?(drink) #K-55~62

  end

  def purchasable_drink_list
    @drinks.each_value do |drink|
      if purchasable?(drink) #K-64~68
        puts "#{drink.name}を買えます"

      else
        puts "#{drink.name}を買えません"
      end
    end
  end #C-32

  def store(drink, num)
    @stocks[drink.name] += num
    @drinks[drink.name] = drink
  end

  def find_drink_by_index(index)
    @drinks.values[index]
  end

  def find_drink_by_name(name) # 名前からDrinkオブジェクトを探す
    @drinks[name]
  end
end

def buy_process(number)
  drink = @vm.find_drink_by_index(number - 1) #K-86~88
  if @vm.total_money < drink.price #AK-45
    puts "お金が足りません"
    exit
  elsif @vm.stocks[drink.name] == 0 #AK-46
    puts "#{drink.name}の在庫がありません"
    exit
  else
    @vm.buy(drink) #K-44~49
    puts "#{drink.name}をお買い上げいただきありがとうございます"
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
    @vm.insert(money) #K-38~42
    puts "#{money}円自動販売機に入れました"
  end
end
