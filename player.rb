require_relative 'card_deck'
require_relative 'card'

class Player
  MAX_NUMBER_OF_CARDS_ALLOWED = 3
  MAX_POINTS_ALLOWED = 21

  attr_accessor :name, :bank, :cards, :points

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @points = 0
    @ace_points = 0
  end

  def get_card(card_deck)
    raise 'Можно добавить только одну карту!' if @cards.size == MAX_NUMBER_OF_CARDS_ALLOWED
    card = card_deck.card_list.sample
    @cards << card
    card_deck.card_list.delete(card)
    add_points(card)
    recalculate_points
  end

  def add_points(card)
    if card.name == 'Ace'
      add_ace_value(card)
      @points += @ace_points
    else
      @points += card.value
    end
  end

  def add_ace_value(card)
    min = @points + (card.value.first)
    max = @points + (card.value.last)
    if max <= MAX_POINTS_ALLOWED
      @ace_points += card.value.last
    else
      @ace_points += card.value.first
    end
  end

  def recalculate_points
    @points -= @ace_points
    @ace_points = 0
    @cards.each { |card| add_points(card) if card.name == 'Ace' }
  end
end
