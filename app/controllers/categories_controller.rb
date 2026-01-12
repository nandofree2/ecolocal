class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  authorize_resource

  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
  end

  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.json { render json: @category, status: :created }
        format.html { redirect_to categories_path, notice: "Create category was successfully created." }
      else
        @q = Category.ransack(params[:q])

        @categories = @q.result.order(created_at: :desc).page(params[:page]).per(20)
        format.html { redirect_to categories_path, alert: @category.errors.full_messages.to_sentence}
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Create category was successfully updated.", status: :see_other }
        format.json { render json: @category, status: :created }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to categories_path, notice: "Category was successfully deleted.", status: :see_other }
        format.json { head :no_content }
      else
        format.html { redirect_to categories_path, alert: "Cannot delete — products still reference this category.", status: :see_other }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :sku, :description)
    end
end
