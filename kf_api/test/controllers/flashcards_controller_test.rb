require 'test_helper'

class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get flashcards_index_url
    assert_response :success
  end

  test 'should get destroy' do
    get flashcards_destroy_url
    assert_response :success
  end
end
