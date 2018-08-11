class ReportController < ApplicationController
  before_action :authenticate_student, :only => [:student_report]
  def generate_report
    @student_course = current_user.student_courses.friendly.find(params[:id])
    @teams = @student_course.teams.all
  end

  def view_report
  end

  def student_report
    @course = current_student.student_courses.friendly.find(params[:id])
    sum = []
    completedTask = []
    @team = Team.find_by_slug(params[:slug])
    @filed_report_detail = FiledProductivityReportDetail.find_by_team_id(@team.id)
    @filed_report_task =  FiledProductivityReportTask.find(:all, :conditions => { :team_id => @team.id })
    @course_students = CourseStudent.all
  end
end
