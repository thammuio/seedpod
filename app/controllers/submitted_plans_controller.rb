class SubmittedPlansController < ApplicationController
  before_action :get_plan_team, :only => [ :new, :edit, :create, :update ]
  before_action :authenticate_student, :is_authorised, :only => [ :new, :create, :edit, :update ]

  def index
    @submitted_plans = SubmittedPlan.all
  end

  def new
    begin
      if @plan_team.status == "Pending"
        @userstory = @team.userstories.all
        @tasks = []
        @course.teams.each do |team|
          team.userstories.each do |team_story|
            team_story.tasks.each do |t|
              @tasks << t
            end
          end
        end
        @submitted_plan = SubmittedPlan.new
        @submitted_plan.submitted_plandetails.build
      else
        render "/public/plan_is_submitted"
      end
    rescue
      render "/public/record_not_found", :layout => false
    end
  end

  def create
    if submitted_plan_params[:submitted_plandetails_attributes][:userstory_id].blank? || submitted_plan_params[:submitted_plandetails_attributes][:estimated_time].blank? || submitted_plan_params[:submitted_plandetails_attributes][:userstory_task_estimate_assigned_to].blank?
      flash[:alert] = "Please fill all the details to submit a plan."
      redirect_to new_submitted_plan_path(@course.slug, @team.slug, @plan.slug)
    else
      @submitted_plan = SubmittedPlan.new(submitted_plan_params)
      if @plan_team.status == "Pending"
        respond_to do |format|
          if @submitted_plan.save
            @submitted_plan.update(:student_id => current_student.id, :team_id => @team.id)

            plan_team = PlanTeam.find_by_plan_id_and_team_id(@plan.id, @team.id)
            plan_team.update(:status => "Waiting")

            @submitted_plan.submitted_plandetails.map do |p|
              @userstory = Userstory.find(p.userstory_id)
              @task = Task.find(p.task_id)
              @userstory.update_column(:in_submitted, true)
              @task.update_column(:is_approved, true)
            end

            @submitted_plan.update(:plan_id => @plan.id)
            format.html { redirect_to student_pending_plans_path(@course, @team.slug), notice: 'Plan was successfully submitted.' }
          end
        end
      else
        render "/public/plan_is_submitted"
      end
    end
  end

  def change_post
    @user_id = params['param_m']
    @userstory = Userstory.find_by_id(@user_id)
    @tasks = @userstory.tasks.all
    @d = params[:id_number]
    # render :text => @tasks
    respond_to :js
  end

  def edit
    if @plan_team.status == "Pending"
      @userstory = @team.userstories.all
      @tasks = []
      @course.teams.each do |team|
        team.userstories.each do |team_story|
          team_story.tasks.each do |t|
            @tasks << t
          end
        end
      end

      @submitted_plan = SubmittedPlan.find_by_plan_id(@plan.id)
    else
      render "/public/plan_is_submitted"
    end
    # @submitted_plan.submitted_plandetails.build
  end

  def update
    if submitted_plan_params[:submitted_plandetails_attributes][:userstory_id].blank? || submitted_plan_params[:submitted_plandetails_attributes][:estimated_time].blank? || submitted_plan_params[:submitted_plandetails_attributes][:userstory_task_estimate_assigned_to].blank?
      flash[:alert] = "Please fill all the details to Re-Submit a plan."
      redirect_to edit_submitted_plan_path(@course.slug, @team.slug, @plan.slug)
    else
      if @plan_team.status == "Pending"
        @submitted_plan = SubmittedPlan.find_by_plan_id(@plan.id)
        respond_to do |format|
          if @submitted_plan.update(submitted_plan_params)
            @submitted_plan.update(:plan_updated_by_student => current_student.id)

            plan_team = PlanTeam.find_by_plan_id_and_team_id(@plan.id, @team.id)
            plan_team.update(:status => "Waiting")

            format.html { redirect_to student_pending_plans_path(@course.slug, @team.slug), notice: 'Plan was successfully submitted.' }
          end
        end
      else
        render "/public/plan_is_submitted"
      end
    end
  end

  private
    def submitted_plan_params
      params.require(:submitted_plan).permit(:team_id, :plan_id, :student_id, :plan_updated_by_student, :submitted_plandetails_attributes => [ :id, :userstory_id, :task_id, :estimated_time, :submitted_plan_id, :userstory_task_estimate_assigned_to, :_destroy])
    end
    def get_plan_team
      begin
        @course = StudentCourse.friendly.find(params[:id])
        @plan = Plan.find_by_slug(params[:title])
        @team = Team.find_by_slug(params[:name])
        # @team = @plan.teams.find_by_slug(params[:name])
        @plan_team = PlanTeam.find_by_plan_id_and_team_id(@plan.id, @team.id)
      rescue Exception => e
        render "/public/record_not_found", :layout => false
      end
    end
end