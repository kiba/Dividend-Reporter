require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :username => "blah",
      :email => "blah@blah.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :admin => false
    }
    @watched = Factory(:stock)
  end
  it "should create a user with valid attributes" do
    User.create!(@attr)
  end

  describe "watchlist" do
    before(:each) do
      @user = User.create!(@attr)
      @watched = Factory(:stock)
    end

    it "should have a watchlists attribute" do
      @user.should respond_to(:watchlists)
    end

    it "should have a watching method" do
      @user.should respond_to(:watching)
    end

    it "should have a watch! method" do
      @user.should respond_to(:watch!)
    end

    it "should watch a stock" do
      @user.watch!(@watched)
      @user.should be_watching(@watched)
    end

    it "should include the watched stock in the watching array" do
      @user.watch!(@watched)
      @user.watching.should include(@watched)
    end

    it "should have an unwatch! method" do
      @user.should respond_to(:unwatch!)
    end

    it "should unwatch a stock" do
      @user.watch!(@watched)
      @user.unwatch!(@watched)
      @user.should_not be_watching(@watched)
    end

  end

end
