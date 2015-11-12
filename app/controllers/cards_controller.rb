class CardsController < ApplicationController
  before_action :check, only: [:show, :edit, :update, :destroy]
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
    @count = Card.review_3_days.count
    @card = Card.find(rand(1..@count))
  end

  def compare
    @cards = Card.find(params[:user_input][:id])
    @user_translation = params[:user_input][:translation]

    if @cards.check_translation(@user_translation)
      flash[:s] = "Right translation"
    else
      flash[:f] = "Wrong translation, right answer - #{@cards.translated_text}."
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
