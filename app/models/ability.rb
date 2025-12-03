class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.persisted?
      if user.role&.name == 'Admin'
        can :manage, :all
      end

      if user.role && user.role.permissions_hash.present?
        user.role.permissions_hash.each do |resource_name, actions|
          begin
            resource_const = resource_name.safe_constantize || resource_name
          rescue StandardError
            resource_const = resource_name
          end

          Array(actions).each do |action|
            if action.to_s == 'see_menu'
              can :see_menu, resource_const
            else
              can action.to_sym, resource_const
            end
          end
        end
      end

      can :edit, User, id: user.id
      can :update, User, id: user.id
    else
      can :read, [Product, Category, UnitOfMeasurement]
    end
  end
end
