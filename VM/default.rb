require "thor"
require "pry"

class Drink
    attr_reader :name, :price

    def initialize(name, price)
        @name = name
        @price = price
    end

    def self.water
        self.new( 'water',100 )
    end

    def self.cola
        self.new( 'cola', 120 )
    end

    def self.redbull
        self.new( 'redbull', 200)
    end
end

puts(Drink.cola.price)
puts(Drink.cola.name)

class VendingMachine
    MONEY = [10, 50, 100, 500, 1000].freeze

    attr_reader :total_money, :sale_amount, :stock
    def initialize
        @total_money = 0
        @sale_amount = 0
        @stock = {cola:5, water:5, redbull: 5}
    end

    def total_money
        @total_money
    end

    def insert(money)   
        if MONEY.include?(money)
            puts "#{money}円自動販売機に入れました"
            @total_money += money 
        else
            puts "#{money}円はこの自動販機では利用できません"
        end
    end

    def buy(drink)
        if @total_money < drink.price
            puts "お金が足りません" 
        elsif  @stock[drink.name.to_sym] == 0
            puts "#{drink.name}の在庫がありません" 
        else
            puts "#{drink.name}をお買い上げ頂きありがとうございます"
            @total_money -= drink.price
            @stock[drink.name.to_sym] -= 1
            @sale_amount += drink.price
            puts "残り#{@total_money}円分購入可能です"
        end
    end

    def return_money
        puts "#{@total_money}円のおつりです"
        @total_money = 0
    end 

    def can_you_buy?(drink)
        stocks = @stock[drink.name.to_sym]
        if @total_money > 120 && stocks > 0 && drink.name == 'cola' 
            "cola:#{stocks}個"
        elsif @total_money > 100 && stocks > 0 && drink.name == 'water' 
            "water:#{stocks}個"
        elsif @total_money > 200 && stocks > 0 && drink.name == 'redbull' 
            "redbull:#{stocks}個"
        else
            "#{drink.name}は買えません"
        end 
    end

    def can_you_buy_list
        puts (can_you_buy?(Drink.cola))
        puts (can_you_buy?(Drink.water))
        can_you_buy?(Drink.redbull)
    end

    def store(drink, num)
        @stock[drink.name.to_sym] += num
    end
end

@ss = VendingMachine.new
@ss.insert(99)
@ss.insert(1000)

puts(@ss.total_money)
puts(@ss.stock[:cola])
puts ""
puts ""
puts "~cola買う~"
@ss.buy(Drink.cola) #[name: "cola", price: 120] 
puts(@ss.stock[:cola])
puts(@ss.total_money)
puts(@ss.sale_amount)
puts "~cola買う~"
@ss.buy(Drink.cola)
puts(@ss.stock[:cola])
puts(@ss.total_money)
puts(@ss.sale_amount)
puts "~cola買う~"
@ss.buy(Drink.cola)
puts(@ss.stock[:cola])
puts(@ss.total_money)
puts(@ss.sale_amount)
puts "~cola買う~"
@ss.buy(Drink.cola)
puts(@ss.stock[:cola])
puts(@ss.total_money)
puts(@ss.sale_amount)
puts "~cola買う~"
@ss.buy(Drink.cola)
puts(@ss.stock[:cola])
puts(@ss.total_money)
puts(@ss.sale_amount)
puts "~cola買う~"
@ss.buy(Drink.cola)
#puts(@ss.return_money)
puts ""
puts ""
puts "~水を買う~"
@ss.buy(Drink.water)
puts(@ss.stock[:water])
puts(@ss.total_money)
puts(@ss.sale_amount)
puts ""
puts ""
puts "~redbullを買う~"
@ss.buy(Drink.redbull)
puts(@ss.stock[:redbull])
puts(@ss.total_money)
puts(@ss.sale_amount)
puts "~redbullを買う~"
@ss.buy(Drink.redbull)
puts(@ss.stock[:redbull])
puts(@ss.total_money)
puts(@ss.sale_amount)
#puts(@ss.return_money)
#puts(@ss.total_money)

puts""
puts""
puts"使い切る"
@ss.buy(Drink.water)
puts(@ss.stock[:redbull])
puts(@ss.total_money)
puts(@ss.sale_amount)

#@ss.buy(Drink.redbull)
#puts (@ss.can_buy_list)
puts ""
puts ""
puts "在庫の点で購入可能なドリンクのリスト"
@ss.insert(1000)
puts(@ss.total_money)
puts (@ss.can_you_buy?(Drink.cola))
puts (@ss.can_you_buy?(Drink.water))
puts (@ss.can_you_buy?(Drink.redbull))
puts ""
puts ""
puts "購入可能リスト"
puts (@ss.can_you_buy_list)
puts ""
puts ""
puts "補充"
@ss.store(Drink.cola, 3)
puts (@ss.can_you_buy_list)
