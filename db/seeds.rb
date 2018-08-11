puts("-------------- Admin is generating --------------")

  User.create(:email => "admin@seedpod.com", :password => "admin123", :is_admin => true)

puts("-------------- Admin generated --------------")


# puts("-------------- Please wait while faculty is being loaded --------------")

#   User.create(:email => "faculty_1@seedpod.com", :password => "faculty123")
#   User.create(:email => "faculty_2@seedpod.com", :password => "faculty123")
#   User.create(:email => "faculty_3@seedpod.com", :password => "faculty123")

# puts("-------------- Faculty created sucessfully --------------")


# puts("-------------- Please wait while faculty is adding their courses --------------")

#   StudentCourse.create(:user_id => 2, :course_name => "Operation Research", :course_id => "OR01", :description => "Test Course 1")
#   StudentCourse.create(:user_id => 2, :course_name => "Maths", :course_id => "MT02", :description => "Test Course 2")

#   StudentCourse.create(:user_id => 3, :course_name => "Network Security", :course_id => "NS605", :description => "Test Course 3")
#   StudentCourse.create(:user_id => 3, :course_name => "Android", :course_id => "MC203", :description => "Test Course 4")

#   StudentCourse.create(:user_id => 4, :course_name => "Data File Structure", :course_id => "DFS054", :description => "Test Course 5")
#   StudentCourse.create(:user_id => 4, :course_name => "ruby On rais", :course_id => "ROR01", :description => "Test Course 6")

# puts("-------------- Course generated sucessfully --------------")
