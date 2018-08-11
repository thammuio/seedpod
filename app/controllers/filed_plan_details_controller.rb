class FiledPlanDetailsController < ApplicationController
  def view_filed_plan_userstory
    if !user_signed_in? && !authenticate_student
      is_authorised
    end
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @plan = Plan.find_by_title(params[:title])
    @team = Team.find_by_slug(params[:name])
    @userstory = FiledPlanUserstory.find_by_slug(params[:slug])
    end
  def view_filed_plan_task
    if !user_signed_in? && !authenticate_student
      is_authorised
    end
    @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
    @plan = Plan.find_by_title(params[:title])
    @team = Team.find_by_slug(params[:name])
    @task = FiledPlanTask.find_by_taksslug(params[:taksslug])
  end
end