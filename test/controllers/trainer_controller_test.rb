require "test_helper"

class TrainerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get trainer_show_url
    assert_response :success
  end
end
