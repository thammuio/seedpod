class PendingPlanApproveController < ApplicationController
  before_action :authenticate_student, :only => [:filed_plan]

  def view_plan
    if user_signed_in?
      @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
      @waiting_to_approve = @student_course.plans.find_by_slug(params[:title])
    else
      @student_course = StudentCourse.friendly.find(params[:id])
      @waiting_to_approve = @student_course.plans.find_by_slug(params[:title])
    end
    get_common_data
  end

  def view_filed_plan
    if user_signed_in?
      @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
      @approved_plans = @student_course.plans.find_by_slug(params[:slug])
    else
      if !authenticate_student
        is_authorised
        @student_course = StudentCourse.friendly.find(params[:id])
        @approved_plans = @student_course.plans.find_by_slug(params[:slug])
      end
    end
    @plan = Plan.find_by_slug(params[:slug])
    @submitted_plan = SubmittedPlan.all
    @team = Team.find_by_slug(params[:name])

    @filed_plan_detail = FiledPlanDetail.find_by_slug(params[:slug])
    @filed_plan_userstory = FiledPlanUserstory.joins(:filed_plan_detail).where(:filed_plan_details => { :id => @filed_plan_detail.id } ).all
    @filed_plan_task = FiledPlanTask.joins(:filed_plan_detail).where(:filed_plan_details => { :id => @filed_plan_detail.id } ).all
  end

  def resend
    ############################################################################################
    # => Renders when faculty will resend a plan to student team                               #
    # => And status of that plan will again move to pending for that team                      #
    # => untill faculty is not approving that plan.                                            #
    ############################################################################################
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @waiting_to_approve = @student_course.plans.find_by_slug(params[:title])
    @submitted_plan = SubmittedPlan.all

    feedback_body = params[:feedback_body]
    @waiting_to_approve.plan_teams.each do |team|
      @submitted_plan.each do |plan|
        if plan.plan_id == team.plan_id && team.status == "Waiting"
          plan.update_attributes(:feedback_body => feedback_body)
        end
      end
    end

    @plan = Plan.find_by_slug(params[:title])
    @team = Team.find_by_slug(params[:name])
    PlanTeam.all.each do |p|
      if p.plan_id == @plan.id && p.team_id == @team.id
        @resend_cnt = 1
        @resend_cnt = p.is_resent + @resend_cnt
        p.update(:status => "Pending", :is_resent => @resend_cnt)
      end
    end
    redirect_to faculty_pending_plans_to_approve_path
  end

  def approve
    ##########################################################################################################
    # => Renders when faculty will Approved a plan for student team                                           #
    # => And status of that plan will be "Approved" and that plan will be accessible to faculty and students #
    # => Under "Filed Plans" but only in read only mode.                                                     #
    ##########################################################################################################
    get_common_data

    plan_team = PlanTeam.find_by_plan_id_and_team_id(@plan.id, @team.id)
    plan_team.update(:status => "Approved")
    @plan.update_column(:is_approved , true)

    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @waiting_to_approve = @student_course.plans.find_by_slug(params[:title])
    filed_userstory = []
    filed_task = []
    @waiting_to_approve.plan_teams.each do |team|
      @submitted_plan.each do |plan|
        if plan.plan_id == team.plan_id && team.status == "Approved"
          plan.submitted_plandetails.each do |pd|
            @userstory.each do |u|
              if u.id == pd.userstory_id
                filed_userstory << u
              end
            end
            @tasks.each do |t|
              if t.id == pd.task_id
                filed_task << t
              end
            end
          end
        end
      end
    end
    @filed_plan_detail = FiledPlanDetail.create(:plan_title => @plan.title, :plan_id => @plan.id, :team_id => @team.id, :course_id => @student_course.id, :slug => @plan.slug)

    FiledPlanUserstory.benchmark('create 500 filed_plan_userstory with activerecord-import gem') do
      columns = [:parent_userstory_id, :title, :description, :estimate, :priority, :status, :userstory_slug]
      values = []
      filed_userstory.each do |u|
        u.update_column(:in_submitted, false)
        values << [u.id, u.title, u.description, u.estimate, u.priority, u.status, u.slug]
      end
      @filed_plan_detail.filed_plan_userstories.import(columns, values, validate: false)
    end

    FiledPlanTask.benchmark('create 500 filed_plan_task with activerecord-import gem') do
      columns = [:parent_task_id, :title, :description, :estimate, :priority, :userstory_id, :team_id, :taksslug]
      values = []
      filed_task.each do |file_task|
        file_task.update_column(:is_approved, false)
        values << [file_task.id, file_task.title, file_task.description, file_task.estimate, file_task.priority, file_task.userstory_id, file_task.team_id, file_task.slug]
      end
      @filed_plan_detail.filed_plan_tasks.import(columns, values, validate: false)
    end
    redirect_to faculty_pending_plans_to_approve_path
  end

  def filed_plan
    ##########################################################################
    # => Renders when Student clicks in filled plan tab from sidebar         #
    # => All filed plans will be listed under template "student_filed_plan". #
    ##########################################################################
    begin
      student_teams_id = []

      current_student.teams.each do |team|
        student_teams_id << team.slug
      end
      if student_teams_id.include?(params[:name])
        @student_course = StudentCourse.friendly.find(params[:id])
        @approved_plans = @student_course.plans.all
        @team = Team.find_by_slug(params[:name])
        render "pending_plan_approve/student_filed_plan"
      else
        render "/errors/not_authorise"
      end
    rescue Exception => e
      render "/public/record_not_found", :layout => false
    end
  end

  def faculty_filed_plan
    ##########################################################################
    # => Renders when faculty clicks in filled plan tab from sidebar         #
    # => All filed plans will be listed under template "faculty_filed_plan". #
    ##########################################################################
    if user_signed_in?
      @student_course = current_user.student_courses.friendly.find_by_course_name(params[:id]) if user_signed_in?
      @approved_plans = @student_course.plans.all
      @student_teams = @student_course.teams
      render "pending_plan_approve/faculty_filed_plan"
    end
  end

  protected
    def get_common_data
      @plan = Plan.find_by_slug(params[:title])
      @submitted_plan = SubmittedPlan.all
      # @submitted_plan_detail = SubmittedPlandetail.all
      @userstory = Userstory.all
      @tasks = Task.all
      @team = Team.find_by_slug(params[:name])
    end
end