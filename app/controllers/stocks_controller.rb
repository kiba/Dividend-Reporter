class StocksController < ApplicationController
  before_filter :require_login, :except => [:index]
  before_filter :admin_user, :except => [:show,:index]

  include QuotesAndStocks
  def index
    @stocks = Stock.all
  end

  def create
    stocks = become_stocks(convert_to_quotes(params[:stocks]))
    @success = []
    @fail = []
    stocks.each do |s|
      stock = Stock.new(s)
      if stock.save
        @success << s[:symbol]
      else
        @fail << s[:symbol]
      end
    end
    redirect_to(stocks_path)
  end
  def show 
   @stock = Stock.find(params[:id])
  end

  def destroy 
    @stock = Stock.find(params[:id]).destroy
    flash[:success] = "Stock successfully removed"
    redirect_to stocks_path
  end
end
