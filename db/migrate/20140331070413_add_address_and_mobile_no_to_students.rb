class AddAddressAndMobileNoToStudents < ActiveRecord::Migration
  def change
    add_column :students, :address, :text
    add_column :students, :mobile_no, :integer
  end
end
