require 'test_helper'

class CategoryProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_product = category_products(:one)
  end

  test "should get index" do
    get category_products_url, as: :json
    assert_response :success
  end

  test "should create category_product" do
    assert_difference('CategoryProduct.count') do
      post category_products_url, params: { category_product: { category_id: @category_product.category_id, product_id: @category_product.product_id } }, as: :json
    end

    assert_response 201
  end

  test "should show category_product" do
    get category_product_url(@category_product), as: :json
    assert_response :success
  end

  test "should update category_product" do
    patch category_product_url(@category_product), params: { category_product: { category_id: @category_product.category_id, product_id: @category_product.product_id } }, as: :json
    assert_response 200
  end

  test "should destroy category_product" do
    assert_difference('CategoryProduct.count', -1) do
      delete category_product_url(@category_product), as: :json
    end

    assert_response 204
  end
end
