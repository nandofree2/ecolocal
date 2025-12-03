module Users
  class SessionsController < Devise::SessionsController
    def new
      redirect_to root_path
    end

    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    rescue Warden::NotAuthenticated
      flash.now[:alert] = I18n.t('devise.failure.invalid', authentication_keys: 'email/password')
      @products_count = Product.count
      @categories_count = Category.count
      @unit_of_measurements_count = UnitOfMeasurement.count
      @users_count = User.count
      render 'dashboards/index'
    end

    protected

    def after_sign_in_path_for(resource)
      root_path
    end

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
  end
end
