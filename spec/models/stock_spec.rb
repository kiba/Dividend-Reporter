require 'spec_helper'

describe Stock do
  before(:each) do
    @attr = {
      :symbol => "KR",
      :company_name => "Kroger Company"
    }
  end
  it "should validates with proper values" do
    Stock.create!(@attr)
  end

  it "should not validates with empty stock symbol" do
    empty = Stock.new(@attr.merge(:symbol => ""))
    empty.should_not be_valid
  end

  it "should not validates when symbol is six characters or longer" do
    toolong = Stock.new(@attr.merge(:symbol => "ASDFASDF"))
    toolong.should_not be_valid
  end

  it "should not validates with empty stock company name" do
    empty = Stock.new(@attr.merge(:company_name => ""))
    empty.should_not be_valid
  end

  describe "quote associations" do
    before(:each) do
      @stock = Factory(:stock)
      @q1 = Factory(:quote, :stock_id => @stock.id, :price => 12)
      @q2 = Factory(:quote, :stock_id => @stock.id, :price => 9)
    end

    it "should have a quotes attribute" do
      @stock.should respond_to(:quotes)
    end

    it "should have the right quotes in the proper order" do
      @stock.quotes.should == [@q2,@q1]
    end

    it "should destroy associated quotes" do
      @stock.destroy
      [@q2,@q1].each do |q|
        Quote.find_by_id(q.id).should be_nil
      end
    end
  end

  describe "watchlist" do
    before(:each) do
      @stock = Stock.create!(@attr)
      @watching = Factory(:user)
    end

    it "should have a watchlists attribute" do
      @stock.should respond_to(:watchlists)
    end

    it "should have a watched method" do
      @stock.should respond_to(:watched)
    end

    it "shoud have a watched? method" do
      @stock.should respond_to(:watched?)
    end

    it "should figure out that it's being watched" do
      @watching.watch!(@stock)
      @stock.should be_watched(@watching)
    end

    it "should figure out that it's not being watched" do
      @watching.watch!(@stock)
      @watching.unwatch!(@stock)
      @stock.should_not be_watched(@watching)
    end
  end



end
