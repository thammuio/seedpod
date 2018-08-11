json.array!(@productivity_reports) do |productivity_report|
  json.extract! productivity_report, :id, :title, :description, :course_id
  json.url productivity_report_url(productivity_report, format: :json)
end
