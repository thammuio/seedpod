json.array!(@student_courses) do |student_course|
  json.extract! student_course, :id, :user_id, :course_name, :team_id
  json.url student_course_url(student_course, format: :json)
end
