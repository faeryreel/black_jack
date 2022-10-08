require_relative 'card'

class CardDeck
  CARD_SUITS = [ '^', '+', '<>', '<3' ]
  NUMBER_CARDS = [ '2', '3', '4', '5', '6', '7', '8', '9', '10' ]
  PICTURE_CARDS = [ 'Jack', 'Queen', 'King', 'Ace' ]

  attr_accessor :card_list

  def initialize
    @card_list = []
    add_number_cards_to_deck
    add_picture_cards_to_deck
    add_aces_to_deck
  end

  def add_number_cards_to_deck
    9.times do |i|
      4.times do |j|
        card = Card.new(NUMBER_CARDS[i], CARD_SUITS[j], NUMBER_CARDS[i].to_i)
        @card_list << card
      end
    end
  end

  def add_picture_cards_to_deck
    3.times do |i|
      4.times do |j|
        card = Card.new(PICTURE_CARDS[i], CARD_SUITS[j], 10)
        @card_list << card
      end
    end
  end

  def add_aces_to_deck
    4.times do |i|
      card = Card.new(PICTURE_CARDS.last, CARD_SUITS[i], [1, 11])
      @card_list << card
    end
  end
end
