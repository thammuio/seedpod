class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_student_course, :except => [:change_password, :update_student_password, :activate, :deactivate, :check_student_exist_for_course ]

  def index
    if params[:all]
      @students = @student_course.student.all
      render "all_students"
    else
      @students = @student_course.student.all
    end
    end

  def show
  end

  def new
    @student = @student_course.student.build
  end

  def edit
  end

  def create
    get_all_emails = student_params[:email].strip
    emails = get_all_emails.strip
    email_array = emails.split(",")
    email_array.each do |ea|
      @student_email = ea.strip
      @student = @student_course.student.new(:email => @student_email)
      @student_uuid = @student.email.split("@")
      @exist_student = Student.find_by_email(@student_email)

      if !@exist_student.blank?
        @course_student = CourseStudent.create(:student_course_id => @student_course.id, :student_id => @exist_student.id )
        UserStoryMailer.invite_existing_student(@student, @student_course).deliver
        # UserStoryMailer.invite_student(@student, @student_course).send_later(:deliver)
      else
        if @student.save
          @course_student = CourseStudent.create(:student_course_id => @student_course.id, :student_id => @student.id )
          UserStoryMailer.invite_student(@student, @student_course).deliver
        end
      end
    end
    redirect_to student_course_students_path(@student_course.slug), notice: 'Student was successfully created.'
  end

  # def create
  #   @student = @student_course.student.new(student_params)
  #   @student_uuid = @student.email.split("@")
  #   @exist_student = Student.find_by_student_name(@student_uuid)

  #   if !@exist_student.blank?
  #     @course_student = CourseStudent.create(:student_course_id => @student_course.id, :student_id => @exist_student.id)
  #     redirect_to student_course_students_path(@student_course.slug), notice: 'Student was successfully created.'
  #     UserStoryMailer.invite_student(@student, @student_course).deliver
  #   else
  #     respond_to do |format|
  #       if @student.save
  #         @course_student = CourseStudent.create(:student_course_id => @student_course.id, :student_id => @student.id )
  #         @password = Array.new(8){rand(36).to_s(36)}.join
  #         @student.update_attributes(:password => @password, :student_name => @student_uuid[0], :is_pwd_change => false)
  #         UserStoryMailer.invite_student(@student, @student_course).deliver

  #         format.html { redirect_to student_course_students_path(@student_course.slug), notice: 'Student was successfully created.' }
  #         format.json { render action: 'show', status: :created, location: @student }
  #       else
  #         format.html { render action: 'new' }
  #         format.json { render json: @student.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      if @student.update(student_params)
        @student_uuid = @student.email.split("@")
        @e = @student.update_attributes(:student_name => @student_uuid[0])
        format.html { redirect_to student_course_students_path(@student_course.slug), notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     @course_student = CourseStudent.where(:student_course_id => @student_course.id, :student_id => @student.id )
    @course_student.destroy_all
    @student.destroy
    respond_to do |format|
      format.html { redirect_to student_course_students_path(@student_course.slug) }
      format.json { head :no_content }
    end
  end

  def deactivate
    @student_course = current_user.student_courses.friendly.find(params[:id])
    student = @student_course.student.find_by_student_name(params[:student_name])
    CourseStudent.all.each do |course_student|
      if course_student.student_course_id == @student_course.id && course_student.student_id == student.id
        course_student.status = "Deactive"
      end
      course_student.save
    end
    redirect_to student_course_students_path(@student_course.slug)+ "?all=students"
  end

  def activate
    begin
      @student_course = current_user.student_courses.friendly.find(params[:id])
      student = @student_course.student.find_by_student_name(params[:student_name])
      CourseStudent.all.each do |course_student|
        if course_student.student_course_id == @student_course.id && course_student.student_id == student.id
          course_student.status = "Active"
        end
        course_student.save
      end
      redirect_to student_course_students_path(@student_course.slug) + "?all=students"
    rescue
      render "/public/record_not_found", :layout => false
    end
  end

  def check_student_exist_for_course
    @student_lists = params["students_email"].split(',')
    @course = current_user.student_courses.friendly.find(params["course_id"])
    @course_students = @course.student.pluck(:email)
    @exist_student = ""
    @student_lists.each do |student_list|
      if @course_students.include?(student_list.strip)
        @exist_student += student_list.strip+',' 
      end
    end
    if @exist_student != ""
      render :text => @exist_student
    else
      render :text => "0"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student_course = StudentCourse.friendly.find(params[:student_course_id])
      @student = @student_course.student.find(params[:id])
    end

    def set_student_course
      begin
        @student_course = current_user.student_courses.friendly.find(params[:student_course_id]) unless nil?
      rescue Exception => e
        render "/public/record_not_found", :layout => false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:email, :password, :student_name, :password_salt, :psd)
    end
end