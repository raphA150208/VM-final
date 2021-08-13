def buy_process(number)
  drink = @vm.find_drink_by_index(number - 1)
  if @vm.total_money < drink.price
    puts "お金が足りません"
    exit
  elsif @vm.stocks[drink.name.to_sym] == 0
    puts "#{drink.name}の在庫がありません"
    exit
  else
    @vm.buy(drink)
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
    @vm.insert(money)
    puts "#{money}円自動販売機に入れました"
  end
end
