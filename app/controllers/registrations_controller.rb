class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  before_filter :authenticate_user!
  def new
    if user_signed_in?
      super
    else
      redirect_to new_user_session_url, :alert => "You need to sign in or sign up before continuing."
    end
  end
  def create
    build_resource(sign_up_params)
    @username = resource.email.split("@")
    if resource.save
      resource.update_attributes(:chng_pwd => false, :username => @username[0])
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        # sign_up(resource_name, resource)
        UserStoryMailer.registration_mail(resource).deliver
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def after_sign_up_path_for(resource)
    admin_dashboard_path
  end
end