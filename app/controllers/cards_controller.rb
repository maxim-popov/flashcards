class CardsController < ApplicationController
  def index
  	 @cards_items = Card.all
  end
end
