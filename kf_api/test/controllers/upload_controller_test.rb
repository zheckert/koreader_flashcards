require "test_helper"

class UploadControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get upload_create_url
    assert_response :success
  end
end
