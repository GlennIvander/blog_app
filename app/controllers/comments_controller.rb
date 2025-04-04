class CommentsController < ApplicationController
  before_action :set_id
  def index
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
      redirect_to article_comments_path(@article), notice: "Yeey. Comment updated."
    else
      flash[:alert] = "Sad. Comment not updated. Must at least 10 characters to be legit"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    if @comment.destroy
      redirect_to article_path(@article), status: :see_other
      flash[:alert] = "Yeey. Comment deleted."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @comment = @article.comments.create(comment_params)

    if @comment.persisted?
      redirect_to article_path(@article), notice: "Yeey. Comment created.", status: :see_other
    else
      flash[:alert] = "Sad. Comment not created. Must at least 10 characters to be legit"
      redirect_to article_path(@article)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

  def set_id
    @article = Article.find(params[:article_id])
  end
end
