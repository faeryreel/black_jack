module GameHelper
  def deal_cards(*players)
    players.each do |player|
      2.times { player.get_card(self.card_deck) }
    end
  end

  def show_cards(*players)
    puts '----------------'
    players.each do |player|
      if (player.name == 'Дилер') && !game_ended?
        puts player.class::SHOW_CARDS_HEADER
        player.cards.each { puts '**' }
      else
        puts player.class::SHOW_CARDS_HEADER
        player.cards.each { |card| puts "#{card.name}#{card.suit}" }
        puts "#{player.class::SHOW_POINTS_HEADER} #{player.points}"
      end
      puts '----------------'
    end
  end

  def game_ended?
    ((self.user.cards.size == self.user.class::MAX_NUMBER_OF_CARDS_ALLOWED) && (self.dealer.cards.size == self.dealer.class::MAX_NUMBER_OF_CARDS_ALLOWED)) || self.user.cards_opened
  end

  def make_stakes(*players)
    self.game_bank = 20
    players.each { |player| player.bank -= 10 }
  end

  def play_game
    while !game_ended? do
      begin
        self.user.make_move(self.card_deck)
      rescue StandardError
        puts "\nМожно добавить только одну карту!"
        puts '----------------'
        retry
      end
      self.dealer.make_move(self.card_deck) if !game_ended?
      show_cards(self.user, self.dealer)
    end
  end

  def end_game
    puts '----------------'
    puts 'Игра окончена!'
    show_cards(self.user, self.dealer)
    calculate_results
    reset_points(self.user, self.dealer)
    puts "На вашем счете #{self.user.bank} долл."
    puts '----------------'
    print "#{@user.name}, хотите сыграть еще раз? Введите 'Да' или 'Нет'. "
  end

  def calculate_results
    if win?
      puts "#{self.user.name}, поздравляем! Вы выиграли."
      send_money(self.user)
    elsif draw?
      puts 'Ничья!'
      divide_money
    elsif lose?
      puts "#{self.user.name}, к сожалению, вы проиграли."
      send_money(self.dealer)
    end
  end

  def win?
    (user_points_greater? && player_points_allowed?(self.user)) || (player_points_allowed?(self.user) && !player_points_allowed?(self.dealer))
  end

  def draw?
    points_equal?
  end

  def lose?
    (!user_points_greater? && player_points_allowed?(self.dealer)) || (player_points_allowed?(self.dealer) && !player_points_allowed?(self.user))
  end

  def user_points_greater?
    self.user.points > self.dealer.points
  end

  def player_points_allowed?(player)
    player.points <= player.class::MAX_POINTS_ALLOWED
  end

  def points_equal?
    self.user.points == self.dealer.points
  end

  def send_money(player)
    player.bank += self.game_bank
    self.game_bank = 0
  end

  def divide_money
    self.user.bank += (self.game_bank / 2)
    self.dealer.bank = self.user.bank
    self.game_bank = 0
  end

  def reset_points(*players)
    players.each do |player|
      player.cards = []
      player.points = 0
    end
  end
end
