class PasswordsController < Devise::PasswordsController
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    if resource.is_admin?
      admin_dashboard_path
    else
      faculty_show_path
    end
  end
end