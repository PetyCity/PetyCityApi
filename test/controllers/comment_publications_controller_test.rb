require 'test_helper'

class CommentPublicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment_publication = comment_publications(:one)
  end

  test "should get index" do
    get comment_publications_url, as: :json
    assert_response :success
  end

  test "should create comment_publication" do
    assert_difference('CommentPublication.count') do
      post comment_publications_url, params: { comment_publication: { body: @comment_publication.body, publication_id: @comment_publication.publication_id, user_id: @comment_publication.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show comment_publication" do
    get comment_publication_url(@comment_publication), as: :json
    assert_response :success
  end

  test "should update comment_publication" do
    patch comment_publication_url(@comment_publication), params: { comment_publication: { body: @comment_publication.body, publication_id: @comment_publication.publication_id, user_id: @comment_publication.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy comment_publication" do
    assert_difference('CommentPublication.count', -1) do
      delete comment_publication_url(@comment_publication), as: :json
    end

    assert_response 204
  end
end
