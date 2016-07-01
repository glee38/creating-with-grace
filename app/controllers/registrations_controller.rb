class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        set_flash_message! :notice, :"almost_finished"
        respond_with resource, location: registration_steps_path(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def registration_steps_path(resource)
    '/registration_steps'
  end
 end 