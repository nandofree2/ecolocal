class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  authorize_resource

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @categories = Category.pluck(:id,:name)
    @unit_of_measurements = UnitOfMeasurement.pluck(:id,:name)
  end

  # GET /products/1/edit
  def edit
    @categories = Category.pluck(:id,:name)
    @unit_of_measurements = UnitOfMeasurement.pluck(:id,:name)
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
    # Handle attachments separately and avoid overwriting attachments when no files are submitted.
    # Build a params hash for update that excludes attachment keys when they are blank.
    update_params = product_params.dup

    # Remove attachment keys when no files were submitted so we don't clear existing attachments
    if params[:product].blank? || params[:product][:cover_image].blank? || (params[:product][:cover_image].respond_to?(:blank?) && params[:product][:cover_image].blank?)
      update_params.delete(:cover_image)
    end

    # Treat preview_images as blank if param is missing, empty, or contains only blank entries
    if params[:product].blank? || params[:product][:preview_images].blank? || (params[:product][:preview_images].respond_to?(:all?) && params[:product][:preview_images].all? { |v| v.blank? })
      update_params.delete(:preview_images)
    end

    # Attach any uploaded files (these will be appended to existing attachments)
    if params[:product].present? && params[:product][:cover_image].present?
      @product.cover_image.attach(params[:product][:cover_image])
    end

    if params[:product].present? && params[:product][:preview_images].present? && !(params[:product][:preview_images].respond_to?(:all?) && params[:product][:preview_images].all? { |v| v.blank? })
      # Enforce max 5 preview images total (existing + new)
      existing_count = @product.preview_images.count
      new_files = Array(params[:product][:preview_images]).reject { |f| f.blank? }
      if existing_count + new_files.size > 5
        flash.now[:alert] = "You can attach up to 5 preview images (you currently have "+existing_count.to_s+")."
        @categories = Category.pluck(:id,:name)
        @unit_of_measurements = UnitOfMeasurement.pluck(:id,:name)
        return render :edit, status: :unprocessable_entity
      end

      @product.preview_images.attach(new_files)
    end

    # Remove attachment keys from params to avoid ActiveStorage being invoked again by update
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
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :sku, :description, :status_product, :quantity, :price, :category_id, :unit_of_measurement_id, :cover_image, preview_images: [])
    end
end
