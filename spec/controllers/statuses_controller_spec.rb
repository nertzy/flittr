require 'spec_helper'

describe StatusesController do
  describe "#show" do
    it "should succeed" do
      get :show, :id => 6361636644
      response.should be_success
    end
  end
end
