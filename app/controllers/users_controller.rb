class UsersController < ApplicationController
  def edit
    @faculty = current_user
  end

  def edit_profile
    @faculty = current_user
  end

  def update
    @faculty = current_user
      respond_to do |format|
      if @faculty.update_attributes(user_params)
        format.html { redirect_to profile_user_path}
        flash[:notice] = 'Your profile was successfully updated.'
        format.json { head :no_content }
      else
        format.html { render "edit" }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    @faculty = User.find(current_user.id)
    if @faculty.update_with_password(password_params)
      sign_in @faculty, :bypass => true
      @faculty.update_attributes(:chng_pwd => true)
      redirect_to faculty_show_path
      flash[:notice] = 'Your password changed successfully.'
    else
      if current_user.chng_pwd?
        render "edit"
        flash[:notice] = 'Please enter valid password.'
      else
        redirect_to faculty_show_path
        flash[:notice] = 'Please enter valid password.'
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name,:last_name,:address,:mobile_no,:email)
    end

    def password_params
      params.required(:user).permit(:current_password,:password, :password_confirmation)
    end
end