class StudentProfileController < ApplicationController
  def edit_profile
    @student = current_student
  end

  def profile
    @student = current_student
      respond_to do |format|
      if @student.update_attributes(student_params)
        format.html { redirect_to edit_student_profile_path(current_student.student_name)}
        flash[:notice] = 'Your profile was successfully updated.'
        format.json { head :no_content }
      else
        format.html { render "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def change_password
    @student = current_student
  end

  def update_student_password
    @student = Student.find(current_student.id)
    current_password = params[:current_password]
    new_password = params[:password]
    password_confirmation = params[:password_confirmation]
    
    if current_password == @student.psd
      password_salt = BCrypt::Engine.generate_salt
      password = BCrypt::Engine.hash_secret(new_password, password_salt)

      if @student.is_pwd_change?
        @student.update_column(:password , password)
        @student.update_column(:password_salt , password_salt)
        @student.update_column(:psd , new_password)
      else
        @student.update_column(:password , password)
        @student.update_column(:password_salt , password_salt)
        @student.update_column(:is_pwd_change , true)
        @student.update_column(:psd , new_password)
      end
      redirect_to courses_path(current_student.student_name)
      flash[:notice] = "You password has been changed successfully."
    else
      if current_student.is_pwd_change?
        render "change_password"
        flash[:notice] = 'Please enter valid password.'
      else
        redirect_to courses_path(current_student.student_name)
        flash[:notice] = 'Please enter valid password.'
      end
    end
  end
  private
    def student_params
      params.require(:student).permit(:address, :mobile_no)
    end
end
