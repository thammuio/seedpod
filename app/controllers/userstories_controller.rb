class UserstoriesController < ApplicationController
  # before_action :set_userstory, only: [:show, :edit, :update, :destroy]
  before_action :current_student_course
  before_action :get_team, :only => [ :index, :show, :new, :create, :update, :destroy ]
  before_action :authenticate_student
  def index
    @course_student = CourseStudent.find(@course)
      if @course_student.status == "Active"
        student_teams_id = []
        current_student.teams.each do |team|
          student_teams_id << team.slug
        end

        if student_teams_id.include?(params[:slug])
          @userstories = @team.userstories.all#(:all, :conditions => { :course_id => @course_wise_userstory.id })
        else
          render "/errors/not_authorise"
        end
      else
      end
    
  end

  def show
    if user_signed_in?
      @userstory = Userstory.find_by_slug(params[:title])
      @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
      render "faculty_userstory_view"
    else
      student_teams_id = []
      current_student.teams.each do |team|
        student_teams_id << team.slug
      end

      if student_teams_id.include?(params[:slug])
        @userstory = Userstory.find_by_slug(params[:title])
        @tasks = Task.joins(:userstory).where(:userstories => { :id => @userstory.id } )
        @userstory_creted_by = Student.find(@userstory.student_id)
      else
        render "/errors/not_authorise"
      end
    end
  end

  def new
    @userstory = @team.userstories.new
  end

  # GET /userstories/1/edit
  def edit
    @userstory = Userstory.find_by_slug(params[:title])
  end

  def create
    @userstory = @team.userstories.new(userstory_params)
    @course = StudentCourse.friendly.find(params[:id])
    respond_to do |format|
      if @userstory.save
        @userstory.update(:course_id => @course.id, :student_id => current_student.id)
        @team.student_courses.each do |p|
          format.html { redirect_to userstories_path(p.slug, @team.slug), notice: 'Userstory was successfully created.' }
          format.json { render action: 'show', status: :created, location: @userstory }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @userstory.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @userstory = Userstory.find_by_slug(params[:title])
    respond_to do |format|
      if @userstory.update(userstory_params)
        @team.student_courses.each do |p|
          format.html { redirect_to userstories_path(p, @team.slug), notice: 'Userstory was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @userstory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @userstory = Userstory.find_by_slug(params[:title])
    @userstory.destroy
    respond_to do |format|
      @team.student_courses.each do |p|
        format.html { redirect_to userstories_path(p.slug, @team.slug) }
        format.json { head :no_content }
      end
    end
  end

  def current_student_course
    begin  
      @course = StudentCourse.friendly.find(params[:id])
    rescue Exception => e
      render "/public/record_not_found", :layout => false
    end
  end

  # def filed_edit_userstories
  #   @userstory = Userstory.find_by_title(params[:title])
  # end

  # def update_filed_userstory
  #   @userstory = Userstory.find_by_title(params[:title])
  #   logger.info "----> #{userstory_params.inspect} <----"
  #   # FiledUserstory.create
  #   exit
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userstory
      @userstory = Userstory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userstory_params
      params.require(:userstory).permit(:title, :description, :estimate, :priority, :status, :student_id, :course_id)
    end

    def exception
      begin
        render [:all]
      rescue Exception => e
        render "/public/record_not_found", :layout => false
      end
    end

    def get_team
      @team = Team.find_by_slug(params[:slug])
    end
end