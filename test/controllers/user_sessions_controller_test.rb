require "test_helper"

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_sessions_path
    assert_response :success
  end

  test "should get create" do
    post user_sessions_path
    assert_response :success
  end
end
