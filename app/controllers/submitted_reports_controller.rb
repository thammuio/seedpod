class SubmittedReportsController < ApplicationController
  before_action :set_submitted_report, only: [:show, :destroy]
  before_action :get_report_team, :only => [ :new, :edit, :create, :update ]
  before_action :authenticate_student, :is_authorised, :only => [ :new, :create, :edit, :update ]

  def index
    @submitted_reports = SubmittedReport.all
  end

  def show
  end

  def new
    begin
      if @report_team.status == "Pending"
        @course = StudentCourse.friendly.find(params[:id])
        @userstory = @team.userstories.all

        @tasks = []
        @course.teams.each do |team|
          team.userstories.each do |team_story|
            team_story.tasks.each do |t|
              @tasks << t
            end
          end
        end
        @submitted_report = SubmittedReport.new
        @submitted_report.submitted_report_details.build
      else
        render "/public/report_is_submitted"
      end
    rescue
      render "/public/record_not_found", :layout => false
    end
  end

  def edit
    if @report_team.status == "Pending"
      @course = StudentCourse.friendly.find(params[:id])
      @userstory = @team.userstories.all

      @tasks = []

      @course = StudentCourse.friendly.find(params[:id])
      @course.teams.each do |team|
        team.userstories.each do |team_story|
          team_story.tasks.each do |t|
            @tasks << t
          end
        end
      end
      @submitted_report = SubmittedReport.find_by_productivity_report_id(@report.id)
    else
      render "/public/report_is_submitted"
    end
  end

  def create
    if @report_team.status == "Pending"
      @course = StudentCourse.friendly.find(params[:id])
      @submitted_report = SubmittedReport.new(submitted_report_params)

      respond_to do |format|
        if @submitted_report.save
          @submitted_report.update(:student_id => current_student.id)
          ProductivityReportTeam.all.each do |p|
            if p.team_id == @team.id && p.productivity_report_id == @report.id
              p.update(:status => "Waiting")
            end
          end
          @submitted_report.update(:productivity_report_id => @report.id)
          format.html { redirect_to student_pending_report_path(@course.slug, @team.slug), notice: 'Submitted report was successfully created.' }
          format.json { render action: 'show', status: :created, location: @submitted_report }
        else
          format.html { render 'new' }
          format.json { render json: @submitted_report.errors, status: :unprocessable_entity }
        end
      end
    else
      render "/public/report_is_submitted"
    end
  end

  def update
    if @report_team.status == "Pending"
      @course = StudentCourse.friendly.find(params[:id])
      @submitted_report = SubmittedReport.find_by_productivity_report_id(@report.id)

      respond_to do |format|
        if @submitted_report.update(submitted_report_params)
          @submitted_report.update(:report_updated_by_student => current_student.id)
          ProductivityReportTeam.all.each do |p|
            if p.team_id == @team.id && p.productivity_report_id == @report.id
              p.update(:status => "Waiting")
            end
          end

          format.html { redirect_to student_pending_report_path(@course.slug, @team.slug), notice: 'Submitted report was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render 'edit' }
          format.json { render json: @submitted_report.errors, status: :unprocessable_entity }
        end
      end
    else
      render "/public/report_is_submitted"
    end
  end

  def destroy
    @submitted_report.destroy
    respond_to do |format|
      format.html { redirect_to submitted_reports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submitted_report
      @submitted_report = SubmittedReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submitted_report_params
      params.require(:submitted_report).permit(:productivity_report_id, :student_id, :report_updated_by_student, :submitted_report_details_attributes => [ :id, :submitted_report_id, :userstory_id, :task_id, :time_worked, :userstory_task_assigned_to, :status, :_destroy])
    end
    def get_report_team
      @report = ProductivityReport.find_by_slug(params[:title])
      @team = @report.teams.find_by_slug(params[:name])
      @report_team = ProductivityReportTeam.find_by_productivity_report_id_and_team_id(@report.id, @team.id)
    end
end