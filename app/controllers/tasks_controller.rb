class TasksController < ApplicationController
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_student, :except => [ :show ]
  def index
    begin
      student_teams_id = []
      current_student.teams.each do |team|
        student_teams_id << team.slug
      end
      if student_teams_id.include?(params[:slug])
        @team = Team.find_by_slug(params[:slug])
        @userstory = @team.userstories.find_by_slug(params[:title])
        @tasks = Task.find(:all, :conditions => { :team_id => @team.id })
      else
        render "/errors/not_authorise"
      end
    rescue Exception => e
      render "/public/record_not_found", :layout => false
    end
  end

  def show
    # begin
      if user_signed_in?
        @student_course = current_user.student_courses.friendly.find(params[:id]) if user_signed_in?
        @task = Task.find_by_slug(params[:taksslug])
        render "faculty_view_task"
      else
        if !authenticate_student
          student_teams_id = []
          current_student.teams.each do |team|
            student_teams_id << team.slug
          end
          if student_teams_id.include?(params[:slug])
            @team = Team.find_by_slug(params[:slug])
            @userstory = @team.userstories.find_by_slug(params[:title])
            @task = Task.find_by_slug(params[:taksslug])
          else
            render "/errors/not_authorise"
          end
        end
      end
    # rescue Exception => e
      # render "/public/record_not_found", :layout => false
    # end
  end

  def new
    @team = Team.find_by_slug(params[:slug])
    @userstory = Userstory.find_by_slug(params[:title])
    @task = @userstory.tasks.new
  end

  def edit
    begin
      @team = Team.find_by_slug(params[:slug])
      @userstory = Userstory.find_by_slug(params[:title])
      @task = Task.find_by_slug(params[:taksslug])
    rescue
      render "/public/record_not_found", :layout => false
    end
  end

  def create
    begin
      @team = Team.find_by_slug(params[:slug])
      @userstory = Userstory.find_by_slug(params[:title])
      @task = @userstory.tasks.new(task_params)
      respond_to do |format|
        if @task.save
          @task.update(:team_id => @team.id)
          @team.student_courses.each do |p|
            format.html { redirect_to userstory_path(p.slug, @team.slug, @userstory.slug), notice: 'Task was successfully created.' }
            format.json { render action: 'show', status: :created, location: @task }
          end
        else
          format.html { render 'new' }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    rescue
      render "/public/record_not_found", :layout => false
    end
  end

  def update
    @team = Team.find_by_slug(params[:slug])
    @userstory = Userstory.find_by_slug(params[:title])
    @task = Task.find_by_slug(params[:taksslug])

    respond_to do |format|
      if @task.update(task_params)
        @team.student_courses.each do |p|
          format.html { redirect_to userstory_path(p.slug, @team.slug, @userstory.slug), notice: 'Task was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @userstory = current_student.userstories.find_by_slug(params[:title])
    @task = Task.find_by_slug(params[:taksslug])
    @task.destroy
    @team = Team.find_by_slug(params[:slug])
    respond_to do |format|
      if params[:applicationPond]
        @team.student_courses.each do |p|
          format.html { redirect_to userstory_path(p.slug, @team.slug, @userstory.slug), notice: 'Task was successfully updated.' }
        end
      else
        format.html { redirect_to tasks_path(@team.slug, @userstory.slug), notice: 'Task was successfully updated.' }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @userstory = current_student.userstories.find(params[:userstory_id])
      @task = Task.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :estimate, :priority, :userstory_id, :team_id, :taksslug, :slug)
    end
end