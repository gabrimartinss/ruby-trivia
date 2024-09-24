class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    users_backoffice_home_index_path
  end
end