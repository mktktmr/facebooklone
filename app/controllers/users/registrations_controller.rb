class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
=begin
  protected

  def update_resource(resource, params)
    if current_user.provider.nil?
      resource.update_with_password(params)
    else
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end
=end
end
