class CardsController < ApplicationController
  def index
    @card = Card.new
  end

  def create
    customer_create
    @card = Card.new(card_params)
    if @card.save
      redirect_to root_path
    else
      render "index"
    end
  end

  private

  def customer_create
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @customer = Payjp::Customer.create(
      description: "test",
      card: params[:card_token]
    )
  end

  def card_params
    params.permit(:card_token).merge(customer_token: @customer.id).merge(user_id: current_user.id)
  end
end
