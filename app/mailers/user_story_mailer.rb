class UserStoryMailer < ActionMailer::Base
  default from: "Seedpod"

  def student_plan_invite(s,plan,student_course, student_team)
    @plan_wise_student = s
    @plan = plan
    @student_team = student_team
    @student_course = student_course
    mail(to: @plan_wise_student.email, subject: 'Seedpod : Request Plan Notification')
  end

  def registration_mail(faculty)
    @user = faculty
    mail(:to => @user.email, :subject => "Seedpod : Registration Notification")
  end

  def invite_student(student, student_course)
    @student = student
    @student_course = student_course
    mail(:to => @student.email, :subject => "Seedpod : Invitation Notification")
  end

  def invite_existing_student(student, student_course)
    @student = student
    @student_course = student_course
    mail(:to => @student.email, :subject => "Seedpod : Course Invitation Notification")
  end

  def productivity_report(report, student_course)
    @report = report
    @student_course = student_course
    mail(:to => "thammuchowdary@gmail.com", :subject => "Seedpod : Productivity Report Notification")
  end
  def password_reset(student)
    @student = student
    mail :to => student.email, :subject => "Password Reset"
  end
end