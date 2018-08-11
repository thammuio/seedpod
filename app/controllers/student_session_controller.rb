class StudentSessionController < ApplicationController
  layout "devise", :only => [ :new, :create ]
  before_action :authenticate_student, :only => [:courses]
  def new
    if current_student.present?
      redirect_to courses_path(current_student.student_name), :notice => "You are already logged in!"
    else
      render 'new'
    end
  end

  def create
    student = Student.authenticate(params[:email], params[:password])
    if student
      session[:student_id] = student.id
      redirect_to courses_path(current_student.student_name), :notice => "Welcome #{student.student_name}."
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:student_id] = nil
    redirect_to "/student/login", :notice => "Logged out!"
  end

  def courses
    # begin
      if current_student.student_name == params[:id]
        @current_student_course = current_student.student_courses
        @current_student_teams = current_student.teams
        @student_cour = current_student.student_courses.includes(:teams)
        @student_tm = current_student.student_teams
        @course_students = CourseStudent.all
      else
        render "/errors/not_authorise"
      end
    
  end

  def edit_student_profile
    @student = current_student
  end
end