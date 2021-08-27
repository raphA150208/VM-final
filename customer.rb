# require 'pry'
require_relative 'kawamurasan'

MONEY = [10, 50, 100, 500, 1000].freeze
@vm = VendingMachine.new  #K-23~42
puts 'こんにちはお客様、あなた望みはなんでしょう？'
puts '1:飲み物を買う事'
puts '2:この会話を止める事'
number = gets.to_i
if number == 2
  puts'そうですか、さようならお元気で'
elsif number == 1
  insert_money_process #K-110~120
  while true
    puts '何を飲みたいですか？'
    puts '1:コーラ'
    puts '2:お水'
    puts '3:レッドブル'
    drink_number = gets.to_i
    buy_process(drink_number) #K-99~112
    puts 'もう一ついかがですか？'
    puts '1:お言葉に甘えて'
    puts '2:もういらないよ'
    number = gets.to_i
    if number == 2
      puts "#{@vm.total_money}円のおつりです"
        @vm.return_money #K55~57
        break
    elsif number == 1
      puts '購入可能なドリンクリストは以下の通りです'
      @vm.purchasable_drink_list #K-72~80
      puts 'お金を追加しますか？'
      puts '1:はい'
      puts '2:いいえ'
      number = gets.to_i
      if number == 1
        insert_money_process #C-14
      end
    end
  end
end


