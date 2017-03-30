require 'test_helper'

class CommentProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment_product = comment_products(:one)
  end

  test "should get index" do
    get comment_products_url, as: :json
    assert_response :success
  end

  test "should create comment_product" do
    assert_difference('CommentProduct.count') do
      post comment_products_url, params: { comment_product: { body: @comment_product.body, product_id: @comment_product.product_id, user_id: @comment_product.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show comment_product" do
    get comment_product_url(@comment_product), as: :json
    assert_response :success
  end

  test "should update comment_product" do
    patch comment_product_url(@comment_product), params: { comment_product: { body: @comment_product.body, product_id: @comment_product.product_id, user_id: @comment_product.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy comment_product" do
    assert_difference('CommentProduct.count', -1) do
      delete comment_product_url(@comment_product), as: :json
    end

    assert_response 204
  end
end
