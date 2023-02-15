class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_student, except: [:show, :index]
  before_action :require_same_student, only: [:edit, :update, :destroy]

  def show
  end

  # GET /articles or /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.student = current_student
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render 'new'
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated." 
    else
      render 'edit'
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article was successfully destroyed." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_student
      if current_student != @article.student && !current_student.admin?
        flash[:alert] = "You can only edit or delete your own article"
        redirect_to @article
      end
    end


end
