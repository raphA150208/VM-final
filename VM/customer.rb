require "thor"
require "pry"
require_relative 'class'

MONEY = [10, 50, 100, 500, 1000].freeze
@vm = VendingMachine.new
@cola = Drink.cola
@water = Drink.water
@redbull = Drink.redbull

puts 'こんにちはお客様、あなた望みはなんでしょう？'
puts '1:飲み物を買う事'
puts '2:この会話を止める事'
number = gets.to_i
if number == 1
  puts 'お金を入れてください'
  money = gets.to_i
  unless MONEY.include?(money)
    puts "#{money}円はこの自動販機では利用できません"
  else
    @vm.insert(money)
    puts "#{money}円自動販売機に入れました"
    while true
      # puts '1:コーラ'
      # puts '2:お水'
      # puts '3:レッドブル'

      buy_process

        # case drink_id
        # when 1
        #   if @vm.total_money < @cola.price
        #     puts "お金が足りません"
        #     break
        #   elsif @vm.stocks[@cola.name.to_sym] == 0
        #     puts "#{@cola.name}の在庫がありません"
        #     break
        #   else
        #     @vm.buy(@cola)
        #     puts 'ガチャン！コーラをお買い上げいただきありがとうございます'
        #     puts "残り#{@vm.total_money}円分購入可能です"
        #   end
        # when 2
        #   if @vm.total_money < @water.price
        #     puts "お金が足りません"
        #     break
        #   elsif @vm.stocks[@water.name.to_sym] == 0
        #     puts "#{@water.name}の在庫がありません"
        #     break
        #   else
        #     @vm.buy(@water)
        #     puts 'ガチャン！お水をお買い上げいただきありがとうございます'
        #     puts "残り#{@vm.total_money}円分購入可能です"
        #   end
        # when 3
        #   if @vm.total_money < @redbull.price
        #     puts "お金が足りません"
        #     break
        #   elsif @vm.stocks[@redbull.name.to_sym] == 0
        #     puts "#{@redbull.name}の在庫がありません"
        #     break
        #   else
        #     @vm.buy(@redbull)
        #     puts 'ガチャン！レッドブルをお買い上げいただきありがとうございます'
        #     puts "残り#{@vm.total_money}円分購入可能です"
        #   end
        # end
        puts 'もう一ついかがですか？'
        puts '1:お言葉に甘えて'
        puts '2:もういらないよ'
        number = gets.to_i
        if number == 1
          buy_process
          puts '購入可能なドリンクリストは以下の通りです'
          display_drink_list(@vm)
          puts 'お金を追加しますか？'
          puts '1:はい'
          puts '2:いいえ'
          number = gets.to_i
          if number == 1
            puts 'お金を入れてください'
            money = gets.to_i
            unless MONEY.include?(money)
              puts "#{money}円はこの自動販機では利用できません"
              break
            else
              @vm.insert(money)
              puts "#{money}円自動販売機に入れました"
            end
          end
        elsif number == 2
          puts "#{@vm.total_money}円のおつりです"
          @vm.return_money
          break
        end
      end
    end
elsif number == 2
  puts'そうですか、さようならお元気で'
end

def display_drink_list(vm)
  puts '何を飲みたいですか？'
  vm.drink_list.each do |drink|
    if drink.purchasable
      "#{drink.id}:#{drink[:name]}:#{drink[:count]}"
    else
      "#{drink.id}:#{drink[:name]}:買えません"
    end
  end
end

def buy_process
  display_drink_list(@vm)
  drink_id = gets.to_i

  drink = @vm.drink_info(drink_id)
  if @vm.buy(drink_id)
    puts "ガチャン！#{drink.name}をお買い上げいただきありがとうございます"
    puts "残り#{@vm.total_money}円分購入可能です"
  else
    puts @vm.error_message
  end
end
