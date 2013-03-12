require 'test_helper'

class ActionsControllerTest < ActionController::TestCase
  test "should get action" do
    get :action
    assert_response :success
  end

end
