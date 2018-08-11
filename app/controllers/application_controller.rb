class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cache_buster
  before_action :authenticate_user!, :only => [ :user ]
  
  def check_for_user_type
    @user_types = UserType.all
  end
  
  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me, :username) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :user_type_id,:first_name,:last_name, :is_admin, :username, :chng_pwd) }
  end

  def report
  end

  def user
    if !current_user.is_admin?
      @faculty = current_user
      @course = current_user.student_courses.all unless !user_signed_in?
    else
      render "/errors/not_authorise"
    end
  end

  def admin
    if user_signed_in? && current_user.is_admin?
      @users = User.find_faculty.all
    else
      redirect_to new_user_session_url, :alert => "You need to sign in or sign up before continuing."
    end
  end

  def check_for_team
    @student_course = StudentCourse.find(params[:id])
    @teams = @student_course.teams.all
  end

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: false, status: 404 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render template: 'errors/internal_server_error', layout: 'layouts/errors', status: 500 }
      format.all  { render nothing: false, status: 500}
    end
  end

  def deactivate
   user = User.find(params[:id])
    user.status = "Deactive"
    user.save
    redirect_to admin_dashboard_path
  end

  def activate
    user = User.find(params[:id])
    user.status = "Active"
    user.save
    redirect_to admin_dashboard_path
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "#{1.year.ago}"
  end

  helper_method :current_student

  private

  def current_student
    @current_student ||= Student.find(session[:student_id]) if session[:student_id]
  end
  def session_clear
    session[:student_id] = nil
    render :text => "session cleared"
  end

  def is_authorised
    student_teams_id = []
    current_student.teams.each do |team|
      student_teams_id << team.slug
    end

    if !student_teams_id.include?(params[:name])
      render "/errors/not_authorise"
    end
  end
  def authenticate_student
    if !session[:student_id]
      redirect_to student_login_path, :notice => "You need to sign in before continuing."
    end
  end
  helper_method :is_authorised, :authenticate_student
end