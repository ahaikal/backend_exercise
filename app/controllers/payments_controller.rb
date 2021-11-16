class PaymentsController < ApplicationController

  def index
  end

  def new
  	@payment = Payment.new
  end

  def create
  	@payment = Payment.new(payment_params)

  	if @payment.make_payment
      flash[:notice] = 'Payment was creted'
      redirect_to root_path
  	else
  		render :new
  	end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_type, :merchant_id, :amount_cents, :bill_me_on,
    																:card_number, :exp_month, :exp_year, :cvc, :billing_zip,
    																:account_number, :routing_number)
  end
end