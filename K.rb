class Drink
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  # 以下3つは、ショートカットとしてあってもよい
  # 定数でもいいかも WATER = self.new('water', 100)
  # def self.water
  #   self.new('ウォーター', 100)
  # end

  # def self.cola
  #   self.new('コーラ', 120)
  # end

  # def self.redbull
  #   self.new('レッドブル', 200)
  # end
end

class VendingMachine
  attr_reader :total_money, :sale_amount, :stocks, :drinks, :bought, :continuing
  # MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @total_money = 0
    @sale_amount = 0
    @stocks = {}
    @stocks.default = 0
    @items = {}

    cola1 = Drink.new('コーラ', 120)
    water1 = Drink.new('ウォーター', 100)
    redbull1 = Drink.new('レッドブル', 200)
    
    @bought = {"コーラ" => 0, "ウォーター" => 0, "レッドブル" => 0} #購入したドリンクの記録
    @continuing = [] #前回購入したドリンクの空配列
    store(cola1, 5)
    store(water1, 5)
    store(redbull1, 10)
  end

  def insert(money) #C-13
    if MONEY.include?(money)
      @total_money += money
    end
  end

  def buy(drink) #C-20
    @total_money -= drink.price
    @stocks[drink.name] -= 1 
    @bought[drink.name] += 1 #購入したドリンク（kye）+1
    
    if @continuing.last == drink.name || @continuing.count == 0 #もし最後に購入したドリンク名が一緒であれば ||または最初の購入であれば
      #.last配列で配列の最後の要素取り出す 
      @continuing << drink.name #continuing配列の中（最後）に入る
    else
      @continuing = []
    end
    puts "3連続購入ありがとう！！！" if @continuing.count == 3 #conのインスタンス変数が連続3の場合 puts表示

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
    @items.each_value do |drink|
      if purchasable?(drink) #K-64~68
        puts "#{drink.name}を買えるよ"

      else
        puts "#{drink.name}を買えません"
      end
    end
  end #C-32

  def store(drink, num)
    @stocks[drink.name] += num
    @items[drink.name] = drink
    binding.irb
  end

  def find_drink_by_index(index)
    @items.values[index]
  end

  def find_drink_by_name(name) # 名前からDrinkオブジェクトを探す
    @items[name]
  end
end

def buy_process(number)
  drink = @vm.find_drink_by_index(number - 1) #K-86~88
  if @vm.total_money < drink.price #AK-45
    puts "お金が足りないよ"
    exit
  elsif @vm.stocks[drink.name] == 0 #AK-46
    puts "#{drink.name}の在庫がなくなちゃった！ゴメン"
    exit
  else
    @vm.buy(drink) #K-44~49
    return_str = rand(1..3)
    puts "翼を授ける〜〜！！\n゜.+ε(・ω・｀*)з゜+゜.+ε(・ω・｀*)з゜+" if return_str == 3 && number == 3

    puts "#{drink.name}美味しいよね！\n\n残り#{@vm.total_money}円分購入できるよ"
  end
end

def insert_money_process
  puts 'お金を入れてね'
  money = gets.to_i
  unless MONEY.include?(money)
    puts "#{money}円は利用できないんだよゴメンね"
    exit
  else
    @vm.insert(money) #K-38~42
    puts "#{money}円入ったよ"
  end
end
