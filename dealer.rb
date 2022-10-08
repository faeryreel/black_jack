class Dealer < Player
  SHOW_CARDS_HEADER = "Карты дилера: \n"
  SHOW_POINTS_HEADER = "Сумма очков дилера:"

  def make_move(card_deck)
    if @points >= 17
      puts "\nДилер решил пропустить свой ход. Ваша очередь!"
      puts '----------------'
    else
      get_card(card_deck)
    end
  end
end
