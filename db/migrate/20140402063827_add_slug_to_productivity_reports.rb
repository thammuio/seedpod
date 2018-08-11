class AddSlugToProductivityReports < ActiveRecord::Migration
  def change
    add_column :productivity_reports, :slug, :string
    add_index :productivity_reports, :slug, :unique => true
  end
end
