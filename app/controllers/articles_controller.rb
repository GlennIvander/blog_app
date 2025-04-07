class ArticlesController < ApplicationController
  before_action :set_id, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key
  def index
    @articles = Article.all
  end

  def show
    @comment = @article.comments.new
  end

  def edit; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_id
    @article = Article.find(params[:id])
  end

  def record_not_found
    redirect_to articles_path, alert: "Record does not exist"
  end

  def invalid_foreign_key
    redirect_to articles_path, alert: "Unable to delete article. Still referenced from comments"
  end
end
