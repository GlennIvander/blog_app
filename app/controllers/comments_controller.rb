class CommentsController < ApplicationController
  before_action :set_id
  before_action :set_action, only: %i[show edit update destroy]
  def index
    @comments = @article.comments
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to article_comments_path(@article), notice: "Yeey. Update successful."
    else
      flash[:alert] = "Sad. Update unsuccessful."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to article_path(@article), status: :see_other
      flash[:alert] = "Yeey. Delete successful."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      redirect_to article_path(@article), notice: "Yeey. Create successful.", status: :see_other
    else
      flash[:alert] = "Sad. Create unsuccessful."
      redirect_to article_path(@article)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def set_id
    @article = Article.find(params[:article_id])
  end

  def set_action
    @comment = @article.comments.find(params[:id])
  end
end
