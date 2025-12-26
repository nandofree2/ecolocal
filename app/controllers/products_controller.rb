class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_categories, only: %i[index new show edit update destroy ]
  authorize_resource

  # GET /products or /products.json
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:category, :unit_of_measurement)
                .order(created_at: :desc)
                .page(params[:page])
                .per(20)
  end



  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @unit_of_measurements = UnitOfMeasurement.pluck(:id, :name)
  end

  # GET /products/1/edit
  def edit
    @unit_of_measurements = UnitOfMeasurement.pluck(:id, :name)
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    update_params = product_params.dup

    if params[:product].blank? || params[:product][:cover_image].blank? || (params[:product][:cover_image].respond_to?(:blank?) && params[:product][:cover_image].blank?)
      update_params.delete(:cover_image)
    end

    if params[:product].blank? || params[:product][:preview_images].blank? || (params[:product][:preview_images].respond_to?(:all?) && params[:product][:preview_images].all? { |v| v.blank? })
      update_params.delete(:preview_images)
    end

    if params[:product].present? && params[:product][:cover_image].present?
      @product.cover_image.attach(params[:product][:cover_image])
    end

    if params[:product].present? && params[:product][:preview_images].present? && !(params[:product][:preview_images].respond_to?(:all?) && params[:product][:preview_images].all? { |v| v.blank? })
      existing_count = @product.preview_images.count
      new_files = Array(params[:product][:preview_images]).reject { |f| f.blank? }
      if existing_count + new_files.size > 5
        flash.now[:alert] = "You can attach up to 5 preview images (you currently have "+existing_count.to_s+")."
        @categories = Category.pluck(:id, :name)
        @unit_of_measurements = UnitOfMeasurement.pluck(:id, :name)
        return render :edit, status: :unprocessable_entity
      end

      @product.preview_images.attach(new_files)
    end

    update_params.delete(:cover_image)
    update_params.delete(:preview_images)

    if @product.update(update_params)
      redirect_to @product, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # DELETE /products/1 or /products/1.json
  def destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to products_path, notice: "Product #{@product.name} was successfully deleted.", status: :see_other }
        format.json { head :no_content }
      else
        format.html { redirect_to products_path, alert: "Cannot delete — products still reference this Product.", status: :see_other }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/:id/preview_images/:attachment_id
  def purge_preview_image
    set_product
    authorize! :update, @product

    attachment = @product.preview_images.find_by(id: params[:attachment_id])
    if attachment
      attachment.purge
      respond_to do |format|
        format.html { redirect_back fallback_location: edit_product_path(@product), notice: "Preview image removed" }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_back fallback_location: edit_product_path(@product), alert: "Image not found" }
        format.json { head :not_found }
      end
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_categories
      @categories = Category.pluck(:id, :name)
    end
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :sku, :description, :status_product, :category_id, :unit_of_measurement_id, :cover_image, preview_images: [])
    end
end
