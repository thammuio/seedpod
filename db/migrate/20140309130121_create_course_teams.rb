class CreateCourseTeams < ActiveRecord::Migration
  def change
    create_table :course_teams do |t|
      t.belongs_to :team
      t.belongs_to :student_course

      t.timestamps
    end
    add_index :course_teams, :team_id
    add_index :course_teams, :student_course_id
  end
end
