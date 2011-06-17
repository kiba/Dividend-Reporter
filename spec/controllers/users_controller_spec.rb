require 'spec_helper'

describe UsersController do
  render_views
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end
    it "should be successful" do
      get 'show', :id => @user
      response.should be_success
    end
  end

  describe "GET 'index'" do
    before(:each) do
      it "should be successful" do
        get 'index'
        response.should be_success
      end
    end
  end



end
