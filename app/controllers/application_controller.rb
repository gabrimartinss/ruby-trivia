class ApplicationController < ActionController::Base
  before_action :set_global_params
  #protected

    #def layout_by_resource
    #  if devise_controller?
    #    "#{resource_class.to_s.downcase}_devise"
    #  else
    #    "application"
    #  end
    #end

  def set_global_params
    $global_params = params
  end
end
