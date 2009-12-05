require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
  end
end
