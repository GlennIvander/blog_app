class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
