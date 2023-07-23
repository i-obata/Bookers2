require "test_helper"

class UesrsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get uesrs_show_url
    assert_response :success
  end

  test "should get edit" do
    get uesrs_edit_url
    assert_response :success
  end
end
