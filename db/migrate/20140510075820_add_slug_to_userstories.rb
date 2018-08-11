class AddSlugToUserstories < ActiveRecord::Migration
  def change
    add_column :userstories, :slug, :string
  end
end
