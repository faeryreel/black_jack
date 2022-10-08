class User < Player
  SHOW_CARDS_HEADER = "Ваши карты: \n"
  SHOW_POINTS_HEADER = "Сумма ваших очков:"

  attr_accessor :cards_opened

  def make_move(card_deck)
    show_move_interface
    n = gets.chomp.to_i
    case n
      when 1
        puts "\nВы решили пропустить ход. Ждите своей очереди!"
        puts '----------------'
      when 2
        get_card(card_deck)
      when 3
        @cards_opened = true
    end
  end

  def show_move_interface
    puts 'Ваш ход! Выберите действие:'
    puts "\n1 - Пропустить ход"
    puts '2 - Добавить карту'
    puts "3 - Открыть карты\n"
  end
end
