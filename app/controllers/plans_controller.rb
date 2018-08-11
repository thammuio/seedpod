class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :find_course, :except => [:faculty_pending_plans_to_approve]
  # before_action :authenticate_user!, :except => [:student_pending_plans]
  before_action :authenticate_student, :only => [ :student_pending_plans ]
  def index
    @plans = @student_course.plans.all
    @student_teams = @student_course.teams
  end

  def show
  end

  def new
    @plan = @student_course.plans.new
    @course_wise_teams = @student_course.teams.all
  end

  def edit
    @course_wise_teams = @student_course.teams.all
  end

  def create
    @plan = @student_course.plans.new(plan_params)
    @course_wise_teams = @student_course.teams.all

    respond_to do |format|
      if @plan.save
        @plan_wise_teams = @plan.teams
        @plan_wise_teams.each do |pt|
          @students = pt.students
            @students.each do |s|
              student_team_name = s.teams
              student_team_name.each do |p|
                @student_team = p
              end
            end
        end
        format.html { redirect_to student_course_plans_path(@student_course.slug), notice: 'Plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to student_course_plans_path(@student_course.slug), notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to student_course_plans_path(@student_course.slug) }
      format.json { head :no_content }
    end
  end

  def student_pending_plans
    student_teams_id = []

    current_student.teams.each do |team|
      student_teams_id << team.slug
    end

    if student_teams_id.include?(params[:slug])
      @course = current_student.student_courses.friendly.find(params[:id])
      @stu_plan = @course.plans.all
      @team = Team.find_by_slug(params[:slug])
    else
      render "/errors/not_authorise"
    end
  end

  def faculty_pending_plans_to_approve
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @stu_plan = @student_course.plans
    @student_teams = @student_course.teams.includes(:plans)
  end

  private
    def set_plan
       @plan = Plan.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:title, :body, :is_pending, :team_ids, :plan_status, :user_id, team_ids: [])
    end

    def find_course
       begin
        @student_course = current_user.student_courses.friendly.find(params[:student_course_id]) if user_signed_in?
      rescue
        render "/public/record_not_found", :layout => false
      end
    end
end