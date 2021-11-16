class TransactionsController < ApplicationController

  def index
    begin
      if params[:payout_id]
        @transactions = Transaction.where(payout_id: params[:payout_id])
      elsif params[:search].present?
        date = Date.parse(params[:search], '%m_%d_%Y')
        @transactions = Transaction.where(created_at: date.beginning_of_day..date.end_of_day)
      else
        @transactions = Transaction.all
      end
    rescue ArgumentError => e
      @transactions = Transaction.all
    end
  end
end
