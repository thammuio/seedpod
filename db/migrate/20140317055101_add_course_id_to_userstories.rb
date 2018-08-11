class AddCourseIdToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :course_id, :integer
  end
end
