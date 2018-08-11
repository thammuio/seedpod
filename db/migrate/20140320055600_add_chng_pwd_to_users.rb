class AddChngPwdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chng_pwd, :boolean
  end
end
