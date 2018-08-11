module ApplicationHelper
  def toggle_like_button(user)
    if user.status == "Active"
      link_to "Deactivate", deactivate_path(user), :class => "btn btn-outline btn-danger btn-sm", :style => "padding: 1px 5px;"
    else
      link_to "Activate", activate_path(user), :class => "btn btn-outline btn-success btn-sm", :style => "padding: 1px 5px;"
    end
  end

  def faculty_add_course_header
    params[:controller] == "student_courses" && params[:action] == "new" ||
    params[:controller] == "student_courses" && params[:action] == "create"
  end

  def student_header
    params[:controller] == "student_session" && params[:action] == "new" ||
    params[:controller] == "student_session" && params[:action] == "create" ||
    params[:controller] == "student_session" && params[:action] == "courses" ||
    params[:controller] == "student_welcomes" && params[:action] == "course_wise_menus" ||
    params[:controller] == "userstories" && params[:action] == "index" ||
    params[:controller] == "userstories" && params[:action] == "new" ||
    params[:controller] == "userstories" && params[:action] == "edit" ||
    params[:controller] == "userstories" && params[:action] == "show"
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def student_signed_in?
    session[:student_id]
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => "btn btn-outline btn-success btn-sm", :id => "add_us")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "btn btn-outline btn-danger btn-xs", :style => "margin-top: 5px;")
  end
end