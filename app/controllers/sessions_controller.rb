class SessionsController < Devise::SessionsController
  def new
    super
  end
  def create
    super
  end
  protected
    def after_sign_in_path_for(resource)
      if resource.is_admin?
        admin_dashboard_path
      else
        faculty_show_path
      end
    end
end