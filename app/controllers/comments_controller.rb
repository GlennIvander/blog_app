class CommentsController < ApplicationController
  before_action :set_id, only: %i[show edit update destroy]
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def show
    @comment = @article.comments.find(params[:id])
  end

  def edit
    @comment = @article.comments.find(params[:id])
  end

  def update
    @comment = @article.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @article, notice: "Yeey. Comment updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

  def set_id
    @article = Article.find(params[:article_id])
  end
end
