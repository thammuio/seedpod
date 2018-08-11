class PendingReportApproveController < ApplicationController
  before_action :set_team_and_report, :only => [:approve, :resend]
  before_action :authenticate_student, :only => [ :filed_report ]
  def view_report
    if user_signed_in?
      @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
      @waiting_to_approve = @student_course.productivity_reports.find_by_slug(params[:title])
    else
      @student_course = StudentCourse.friendly.find(params[:id])
      @waiting_to_approve = @student_course.productivity_reports.find_by_title(params[:title])
    end

    get_common_data

    @submitted_report_details = []

    @waiting_to_approve.productivity_report_teams.each do |team|
      @submitted_report.each do |report|
        if report.productivity_report_id == team.productivity_report_id && team.status == "Waiting"
          report.submitted_report_details.each do |pd|
            @submitted_report_details << pd
          end
          render :template => "pending_report_approve/view_report"
        elsif report.productivity_report_id == team.productivity_report_id && team.status == "Approved"
          report.submitted_report_details.each do |pd|
            @submitted_report_details << pd
          end
          render :template => "pending_report_approve/view_approve_report_details"
        end
      end
    end
  end

  def view_filed_report
    if user_signed_in?
      @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
      @approved_reports = @student_course.productivity_reports.find_by_slug(params[:slug])
    else
      @student_course = StudentCourse.friendly.find(params[:id])
      @approved_reports = @student_course.productivity_reports.find_by_slug(params[:slug])
    end
    @submitted_report = SubmittedReport.all
    @report = ProductivityReport.find_by_slug(params[:slug])
    @team = Team.find_by_slug(params[:name])

    @filed_report_detail = FiledProductivityReportDetail.find_by_slug(params[:slug])
    @filed_report_userstory = FiledProductivityReportUserstory.joins(:filed_productivity_report_detail).where(:filed_productivity_report_details => { :id => @filed_report_detail.id } ).all
    @filed_report_task = FiledProductivityReportTask.joins(:filed_productivity_report_detail).where(:filed_productivity_report_details => { :id => @filed_report_detail.id } ).all
  end

  def resend
    ############################################################################################
    # => Renders when faculty will resend a report to student team                               #
    # => And status of that report will again move to pending for that team                      #
    # => untill faculty is not approving that report.                                            #
    ############################################################################################
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @waiting_to_approve = @student_course.productivity_reports.find_by_slug(params[:title])
    @submitted_report = SubmittedReport.all
    feedback_body = params[:feedback_body]

    @waiting_to_approve.productivity_report_teams.each do |team|
      @submitted_report.each do |report|
        if report.productivity_report_id == team.productivity_report_id && team.status == "Waiting"
          report.update_attributes(:feedback_body => feedback_body)
        end
      end
    end

    ProductivityReportTeam.all.each do |p|
      if p.productivity_report_id == @report.id && p.team_id == @team.id
        @resend_cnt = 1
        @resend_cnt = p.is_resent + @resend_cnt
        p.update(:status => "Pending", :is_resent => @resend_cnt)
      end
    end
    redirect_to faculty_pending_reports_to_approve_path
  end

  def approve
    ##############################################################################################################
    # => Renders when faculty will Approve a report for student team                                             #
    # => And status of that report will be "Approved" and that report will be accessible to faculty and students #
    # => Under "Filed Report" but only in read only mode.                                                        #
    ##############################################################################################################
    report_team = ProductivityReportTeam.find_by_productivity_report_id_and_team_id(@report.id, @team.id)
    report_team.update(:status => "Approved")
    @report.update_column(:is_approved , true)

    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @waiting_to_approve = @student_course.productivity_reports.find_by_slug(params[:title])
    filed_userstory = []
    filed_task = []
    userstory_task_assigned_to = []
    days_worked = []
    task_status = []
    @waiting_to_approve.productivity_report_teams.each do |report_team|
      SubmittedReport.all.each do |report|
        if report.productivity_report_id == report_team.productivity_report_id && report_team.status == "Approved"
          report.submitted_report_details.each do |pd|
            Userstory.all.each do |u|
              if u.id == pd.userstory_id
                filed_userstory << u
              end
            end
            Task.all.each do |t|
              if t.id == pd.task_id
                filed_task << t
                userstory_task_assigned_to << pd.userstory_task_assigned_to
                days_worked << pd.time_worked
                task_status << pd.status
              end
            end
          end
        end
      end
    end

    @filed_report_detail = FiledProductivityReportDetail.create(:report_title => @report.title, :productivity_report_id => @report.id, :team_id => @team.id, :course_id => @student_course.id, :slug => @report.slug)

    FiledProductivityReportUserstory.benchmark('create 500 filed_productivity_report_userstories with activerecord-import gem') do
      columns = [:parent_userstory_id, :title, :description, :estimate, :priority, :status, :userstory_slug]
      values = []
      filed_userstory.each do |u|
        values << [u.id, u.title, u.description, u.estimate, u.priority, u.status, u.slug]
      end
      @filed_report_detail.filed_productivity_report_userstories.import(columns, values, validate: false)
    end

    FiledPlanTask.benchmark('create 500 filed_plan_tasks with activerecord-import gem') do
      columns = [:parent_task_id, :title, :description, :estimate, :priority, :userstory_id, :team_id, :taskslug, :userstory_task_assigned_to, :days_worked, :status]
      values = []
      
      filed_task.zip(userstory_task_assigned_to, days_worked, task_status).each do |file_task, task_assigned_to, days_worked, task_status|
        values << [file_task.id, file_task.title, file_task.description, file_task.estimate, file_task.priority, file_task.userstory_id, file_task.team_id, file_task.slug, task_assigned_to, days_worked, task_status]
      end
      @filed_report_detail.filed_productivity_report_tasks.import(columns, values, validate: false)
    end
    redirect_to faculty_pending_reports_to_approve_path
  end

  def faculty_filed_report
    #############################################################################
    # => Renders when faculty clicks in filled report tab from sidebar          #
    # => All filed reports will be listed under template "faculty_filed_report".#
    #############################################################################

    if user_signed_in?
      @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
      @approved_reports = @student_course.productivity_reports.all
      @student_teams = @student_course.teams
      render "pending_report_approve/faculty_filed_report"
    end
  end

  def filed_report
    ##############################################################################
    # => Renders when Student clicks in filled report tab from sidebar           #
    # => All filed reports will be listed under template "student_filed_report". #
    ##############################################################################

    student_teams_id = []

    current_student.teams.each do |team|
      student_teams_id << team.slug
    end
    if student_teams_id.include?(params[:slug])
      @student_course = current_student.student_courses.friendly.find(params[:id])
      @approved_reports = @student_course.productivity_reports.all
      @team = Team.find_by_slug(params[:slug])
      render "pending_report_approve/student_filed_report"
    else
      render "/errors/not_authorise"
    end
  end
  def get_common_data
    @submitted_report = SubmittedReport.all
    @submitted_plan_detail = SubmittedReportDetail.all
    @userstory = Userstory.all
    @tasks = Task.all
    @report = ProductivityReport.find_by_slug(params[:title])
    @team = Team.find_by_slug(params[:slug])
  end
  private
    def set_team_and_report
      @report = ProductivityReport.find_by_slug(params[:title])
      @team = Team.find_by_slug(params[:slug])
    end
end