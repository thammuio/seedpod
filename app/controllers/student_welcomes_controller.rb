class StudentWelcomesController < ApplicationController
  def course_wise_menus
    @course = StudentCourse.find_by_course_name(params[:course_name])
    @userstories = Userstory.all
  end
end