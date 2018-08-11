json.array!(@submitted_reports) do |submitted_report|
  json.extract! submitted_report, :id, :productivity_report_id, :student_id, :report_updated_by_student
  json.url submitted_report_url(submitted_report, format: :json)
end
