require "test_helper"

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch" do
    get data_fetch_url
    assert_response :success
  end
end
