class Drink
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end

class VendingMachine
  attr_reader :total_money, :sale_amount, :stocks, :drinks, :bought, :continuing
  def initialize
    @total_money = 0
    @sale_amount = 0
    @stocks = {}
    @stocks.default = 0
    @items = {}

    cola1 = Drink.new('コーラ', 10)
    water1 = Drink.new('ウォーター', 10)
    redbull1 = Drink.new('レッドブル', 10)
    @consecutive_redbull = {"レッドブル" => 0} #購入したドリンクの記録
    store(cola1, 10)
    store(water1, 10)
    store(redbull1, 10)
  end

  def insert(money) #C-13
    if MONEY.include?(money)
      @total_money += money
    end
  end

  def buy(drink) #C-20
    if drink.name == "レッドブル"
      @consecutive_redbull["レッドブル"] += 1 #購入したドリンク（kye）+1
    else
      @consecutive_redbull.store("レッドブル", 0)
    end
    if (drink.name == "レッドブル") && (@consecutive_redbull["レッドブル"] >= 4)
      refuse = rand(1..3)
      if refuse == 1
        puts 'お断りします'
        puts '　　お断りします'
        puts '　　 ハハ ハハ'
        puts '　　 (ﾟωﾟ)ﾟωﾟ)'
        puts '　　／　　＼　 ＼'
        puts '((⊂ ) 　ﾉ＼つﾉ＼つ)'
        puts '　　 (＿⌒ヽ ⌒ヽ'
        puts '　　 ヽ　ﾍ |　ﾍ |'
        puts 'εﾆ三 ﾉノ Ｊノ Ｊ'
      elsif refuse == 2
        puts '    お断りします'
        puts '　 　 　＿＿_'
        puts '　　 ／| ﾊ_ﾊ　 |'
        puts '　 ||　（ﾟωﾟ ）|'
        puts '　 || と_　 Ｕ |'
        puts '　 ||　|（_）ﾉ |'
        puts '　 ||／彡 ￣　ｶﾞﾁｬ'
      elsif refuse == 3
        puts '┌ ○ ┐ お断りします'
        puts '│ お│ハハ'
        puts '│ 断│ ﾟωﾟ)'
        puts '│ り│／/'
        puts '└ ○ ┘(⌒)'
        puts '　 し⌒'
      end
    else
      @total_money -= drink.price
      @stocks[drink.name] -= 1
      @sale_amount += drink.price
    end

    def redbull_count
      @consecutive_redbull["レッドブル"]
    end
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
    return if @vm.redbull_count >= 4
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
