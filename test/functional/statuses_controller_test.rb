require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  test 'show' do
    get :show, :id => 6361636644
    assert_response :success
  end
end
