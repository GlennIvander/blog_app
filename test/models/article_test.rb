require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "the truth" do
    article = Article.new
    article.title = nil
    article.body = "I am the best"
    assert article.save
  end
end
