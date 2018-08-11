class CreateStudentTeams < ActiveRecord::Migration
  def change
    create_table :student_teams do |t|
      t.belongs_to :student
      t.belongs_to :team

      t.timestamps
    end
    add_index :student_teams, :student_id
    add_index :student_teams, :team_id
  end
end