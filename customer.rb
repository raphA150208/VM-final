require_relative 'masterk'

MONEY = [10, 50, 100, 500, 1000]
@vm = VendingMachine.new  #K-9~25
puts 'いらっしゃい！！'
puts '1:飲み物を買う'
puts '2:買うのやめる！'
number = gets.to_i
if number == 2
  puts'バイバイ'
elsif number == 1
  @vm.insert_money_process #K-121~131
  while true
    puts '何を飲む？'
    puts '1:コーラ'
    puts '2:お水'
    puts '3:レッドブル'
    drink_number = gets.to_i
    @vm.buy_process(drink_number) #K-133~149
    puts 'もう一本買っちゃえよ！'
    puts '1:買う'
    puts '2:もういらない'
    number = gets.to_i
    if number == 2
      puts "#{@vm.total_money}円のおつりだよ！"
        @vm.return_money #K51~53
        break #繰り返し処理を途中で終了させる
    elsif number == 1
      puts '購入可能なドリンクリストは↓だよ！'
      @vm.purchasable_drink_list #K-70~79
      puts 'お金を追加する？'
      puts '1:はい'
      puts '2:いいえ'
      number = gets.to_i
      if number == 1
        @vm.insert_money_process #C-14
      end
    end
  end
end


