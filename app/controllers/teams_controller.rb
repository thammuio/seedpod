class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_student_course,  except: [:show]

  def index
    @teams = @student_course.teams.all
  end

  def show
    if user_signed_in?
      @student_course = current_user.student_courses.friendly.find(params[:student_course_id]) unless nil?
    else
      if !authenticate_student
        student_teams_id = []
          current_student.teams.each do |team|
            student_teams_id << team.slug
         end
           if student_teams_id.include?(params[:id])
          @student_course = StudentCourse.friendly.find(params[:student_course_id]) unless nil?
        else
          render "/errors/not_authorise"
        end
      end
    end
    @team_students = @team.students.all
  end

  def new
    @team = @student_course.teams.build
    @course_wise_students = @student_course.student.all
    get_student_are_in_team_or_not # Method calling
  end

  def edit
    @course_wise_students = @student_course.student.all
    @students = Student.all
    get_student_are_in_team_or_not # Method calling
  end

  def create
    @team = @student_course.teams.new(team_params)

    respond_to do |format|
      if @team.save
        @course_team = CourseTeam.create(:student_course_id => @student_course.id, :team_id => @team.id )
        format.html { redirect_to student_course_team_path(@student_course,@team), notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to student_course_teams_path(@student_course), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course_student = CourseTeam.where(:student_course_id => @student_course.id,  :team_id => @team.id )
    @course_student.destroy_all
    @team.destroy
    respond_to do |format|
      format.html { redirect_to student_course_teams_url }
      format.json { head :no_content }
    end
  end
  private
    def get_student_are_in_team_or_not
      begin
        @course_wise_students = @student_course.student.all
        @student_who_are_in_team = []

        @student_course.teams.each do |team|
          team.students.each do |student|
            @student_who_are_in_team << student
          end
        end
        @student_who_are_not_in_team = [ @student_course.student - @student_who_are_in_team]
      rescue Exception => e
        render "/public/record_not_found", :layout => false
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      begin
        @team = Team.friendly.find(params[:id])
      rescue Exception => e
        render "/public/record_not_found", :layout => false
      end
    end

    def set_student_course
      begin
        @student_course = current_user.student_courses.friendly.find(params[:student_course_id]) unless nil?
      rescue Exception => e
        render "/public/record_not_found", :layout => false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      # params.require(:team).permit(:user_id, :name)
      params[:team].permit :name, :slug, :user_id, student_ids: []
    end
end