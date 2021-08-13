require "thor"
require "pry"
require_relative 'class'
require_relative 'customer'

customerと繋ぐときはコメントアウト
@vm = VendingMachine.new
@cola = Drink.cola
@water = Drink.water
@redbull = Drink.redbull

puts 'こんにちは、管理者さん'
puts '本日はどんなごようでしょうか？'
puts '1:集金ですよ'
puts '2:在庫を確認したくてですね'
puts '3:元気にしてるか気になって、、'
number = gets.to_i
if number == 1
  if @vm.sale_amount == 0
    puts '残念ながら、売り上げはありません'
  else
    puts "#{@vm.sale_amount}円の売り上げです"
    puts 'どうぞお受け取りくださいませ'
  end
elsif number == 2
  while true
    puts '在庫は以下の通りです'
    puts"コーラ：#{@vm.stocks[@cola.name.to_sym]}"
    puts"お水：#{@vm.stocks[@water.name.to_sym]}"
    puts"レッドブル：#{@vm.stocks[@redbull.name.to_sym]}"
    puts '在庫の補充を行いますか？'
    puts '1:はい'
    puts '2:いいえ'
    number = gets.to_i
    if number == 1
      puts '何を補充しますか？'
      puts '1:コーラ'
      puts '2:お水'
      puts '3:レッドブル'
      number = gets.to_i
      puts '何個補充しますか？'
      count_number = gets.to_i
      case number
      when 1
        @vm.store(@cola, count_number)
        puts "コーラが#{count_number}個補充されました"
      when 2
        @vm.store(@water, count_number)
        puts "お水が#{count_number}個補充されました"
      when 3
        @vm.store(@redbull, count_number)
        puts "レッドブルが#{count_number}個補充されました"
      end
    elsif number == 2
      puts 'そうですか、それではまたの機会に' 
      break
    end
  end
elsif number == 3
  puts '元気ですよ、ありがとう'
end