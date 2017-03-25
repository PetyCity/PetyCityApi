require 'test_helper'

class ComentProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coment_product = coment_products(:one)
  end

  test "should get index" do
    get coment_products_url, as: :json
    assert_response :success
  end

  test "should create coment_product" do
    assert_difference('ComentProduct.count') do
      post coment_products_url, params: { coment_product: { body: @coment_product.body, product_id: @coment_product.product_id, user_id: @coment_product.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show coment_product" do
    get coment_product_url(@coment_product), as: :json
    assert_response :success
  end

  test "should update coment_product" do
    patch coment_product_url(@coment_product), params: { coment_product: { body: @coment_product.body, product_id: @coment_product.product_id, user_id: @coment_product.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy coment_product" do
    assert_difference('ComentProduct.count', -1) do
      delete coment_product_url(@coment_product), as: :json
    end

    assert_response 204
  end
end
