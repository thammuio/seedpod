class FiledProductivityReportDetailsController < ApplicationController
  def view_filed_productivity_report_userstory
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @report = ProductivityReport.find_by_title(params[:title])
    @team = Team.find_by_slug(params[:name])
    @userstory = FiledProductivityReportUserstory.find_by_userstory_slug(params[:userstory_slug])
  end
  def view_filed_productivity_report_task
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @report = ProductivityReport.find_by_title(params[:title])
    @team = Team.find_by_slug(params[:name])
    @task = FiledProductivityReportTask.find_by_taskslug(params[:taskslug])
  end
end