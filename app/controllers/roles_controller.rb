class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_role, only: %i[ show edit update destroy ]

  # GET /roles or /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1 or /roles.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    @role = Role.new(role_params)
    if params[:role] && params[:role][:permissions]
      @role.permissions = sanitize_permissions_param(params[:role][:permissions])
    end

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: "Role was successfully created." }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    if params[:role] && params[:role][:permissions]
      @role.permissions = sanitize_permissions_param(params[:role][:permissions])
    end

    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: "Role was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy!

    respond_to do |format|
      format.html { redirect_to roles_path, notice: "Role was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name, :description)
    end

    def sanitize_permissions_param(raw)
      return {} unless raw.is_a?(ActionController::Parameters) || raw.is_a?(Hash)

      clean = {}
      raw.to_unsafe_h.each do |resource, actions|
        clean[resource.to_s] = Array(actions).reject(&:blank?).map(&:to_s)
      end
      clean
    end

    def authorize_admin
      redirect_to root_path, alert: "Not authorized" unless current_user&.role&.name == "Admin"
    end
end
