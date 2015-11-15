class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @cards = Card.find(params[:id])
  end

  def new
    @cards = Card.new
  end

  def edit
    @cards = Card.find(params[:id])
  end

  def check
    @card = Card.time_to_check_card.first
    @count = Card.time_to_check_card.count
  end

  def compare
    @cards = Card.find(params[:user_input][:id])
    if @cards.check_translation(params[:user_input][:translation]) == false
      flash.now[:f] = "Wrong translation, right answer - #{@cards.translated_text}."
    else
      flash.now[:s] = "Right translation"
    end
    redirect_to check_path
  end

  def create
    @cards = Card.new(card_params)
    if @cards.save
      redirect_to @cards
    else
      render 'new'
    end
  end

  def update
    @cards = Card.find(params[:id])

    if @cards.update(card_params)
      redirect_to @cards
    else
      render 'edit'
    end
  end

  def destroy
    @cards = Card.find(params[:id])
    @cards.destroy
    redirect_to @cards
  end

  private
  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end


end
