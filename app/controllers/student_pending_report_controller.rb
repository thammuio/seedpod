class StudentPendingReportController < ApplicationController
  before_action :authenticate_student
  def pending_report
    student_teams_id = []

    current_student.teams.each do |team|
      student_teams_id << team.slug
    end

    if student_teams_id.include?(params[:slug])
      @course = current_student.student_courses.friendly.find(params[:id])
      @stu_plan = @course.productivity_reports.all
      @team = Team.find_by_slug(params[:slug])
    else
      render "/errors/not_authorise"
    end
  end
end