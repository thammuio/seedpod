class PasswordResetsController < ApplicationController
  layout "devise", :only => [ :new, :create ]
  def new
  end
  def create
    student = Student.find_by_email(params[:email])
    if student
      student.send_password_reset
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      redirect_to new_password_reset_path, :alert => "Email not found!"
    end
  end
  def edit
    if current_student
      redirect_to courses_path(current_student.student_name)
    elsif user_signed_in?
      redirect_to faculty_show_path
    else
      @student = Student.find_by_password_reset_token!(params[:id])
    end
  end
  def update
    @student = Student.find_by_password_reset_token!(params[:id])
    if @student.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."
    else
      reset_new_password = password_params[:password]
      password_salt = BCrypt::Engine.generate_salt
      password = BCrypt::Engine.hash_secret(reset_new_password, password_salt)
      @student.update_column(:password , password)
      @student.update_column(:password_salt , password_salt)
      @student.update_column(:psd , reset_new_password)
      redirect_to root_url, :notice => "Password has been reset."
    # else
    # exit
    #   render :edit
    end
  end
  private
    def password_params
      params.require(:student).permit(:password)
    end
end