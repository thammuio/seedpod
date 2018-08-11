class StudentCoursesController < ApplicationController
  before_action :set_student_course, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
  end

  def show
    begin
      @student_course = current_user.student_courses.friendly.find(params[:id])
      @teams = @student_course.teams.all
    rescue Exception => e
      render "/public/record_not_found", :layout => false
    end
  end

  def new
    @student_course = current_user.student_courses.new
  end

  def edit
  end

  def create
    @student_course = current_user.student_courses.new(student_course_params)

    respond_to do |format|
      if @student_course.save
        format.html { redirect_to faculty_show_path, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @student_course }
      else
        format.html { render action: 'new' }
        format.json { render json: @student_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @student_course.update(student_course_params)
        format.html { redirect_to @student_course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student_course.destroy
    respond_to do |format|
      format.html { redirect_to student_courses_url }
      format.json { head :no_content }
    end
  end

  private
    def set_student_course
      begin
      @student_course = current_user.student_courses.friendly.find(params[:id])
    rescue Exception => e
      render "/public/record_not_found", :layout => false
    end
  end

    def student_course_params
      params.require(:student_course).permit(:user_id ,:course_name, :team_id, :course_id, :description, :slug)
    end
end