require_relative 'player'
require_relative 'dealer'
require_relative 'user'
require_relative 'card_deck'
require_relative 'card'
require_relative 'game_helper'

class Game
  include GameHelper

  attr_accessor :user, :dealer, :card_deck, :game_bank

  def launch_game
    print 'Как вас зовут? '
    @user = User.new(gets.chomp)
    @dealer = Dealer.new('Дилер')
    start_new_game
  end

  def start_new_game
    loop do
      puts '----------------'
      puts 'Начинаем новую игру!'
      @user.cards_opened = false
      @card_deck = CardDeck.new
      deal_cards(@user, @dealer)
      show_cards(@user, @dealer)
      make_stakes(@user, @dealer)
      play_game
      end_game
      break if gets.chomp.capitalize == 'Нет'
    end
  end
end
