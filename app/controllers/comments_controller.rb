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
      redirect_to article_comments_path(@article), notice: "Yeey. Sumakses ang update bes."
    else
      flash[:alert] = "Sad. Not sakses ang update mo bes. Must at least 10 characters to be legit"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to article_path(@article), status: :see_other
      flash[:alert] = "Yeey. Sumakses ang delete bes."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      redirect_to article_path(@article), notice: "Yeey. Sumakses ang create bes.", status: :see_other
    else
      flash[:alert] = "Sad. Not sakses ang create mo bes. Must have a commenter and at least 10 characters to be legit"
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

  def set_action
    @comment = @article.comments.find(params[:id])
  end
end
