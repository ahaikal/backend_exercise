class PayoutsController < ApplicationController

  def index
    @payouts = Payout.all
  end

  def new
  	@payout = Payout.new
  end

  def create
    @payout = Payout.new(payout_params)

    if @payout.save
      flash[:notice] = 'Payout was created'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def payout_params
    params.require(:payout).permit(:merchant_id)
  end
end
