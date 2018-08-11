class AddUserstorySlugToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :userstory_slug, :string
  end
end
