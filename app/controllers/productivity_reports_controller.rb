class ProductivityReportsController < ApplicationController
  before_action :set_productivity_report, only: [:show, :edit, :update, :destroy]
  before_action :find_course, :except => [:faculty_pending_reports_to_approve]

  def index
    @productivity_reports = @student_course.productivity_reports
    @student_teams = @student_course.teams
  end

  def show
  end

  def new
    @productivity_report = @student_course.productivity_reports.new
    @report_wise_teams = @student_course.teams.all
  end

  def edit
    @report_wise_teams = @student_course.teams.all
  end

  def create
     @productivity_report = @student_course.productivity_reports.new(productivity_report_params)

    respond_to do |format|
      if @productivity_report.save
        
        format.html { redirect_to student_course_productivity_reports_path(@student_course.slug), notice: 'Productivity report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @productivity_report }
      else
        format.html { render 'new' }
        format.json { render json: @productivity_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @productivity_report.update(productivity_report_params)
        format.html { redirect_to student_course_productivity_reports_path(@student_course.slug), notice: 'Productivity report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @productivity_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @productivity_report.destroy
    respond_to do |format|
      format.html { redirect_to student_course_productivity_reports_path(@student_course.slug) }
      format.json { head :no_content }
    end
  end

  def faculty_pending_reports_to_approve
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @student_pending_report_to_approve = @student_course.productivity_reports
    @student_teams = @student_course.teams
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_productivity_report
      @productivity_report = ProductivityReport.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def productivity_report_params
      params.require(:productivity_report).permit(:title, :description, :student_course_id, team_ids: [])
    end

    def find_course
      @student_course = current_user.student_courses.friendly.find(params[:student_course_id]) if user_signed_in?
    end
end