class AddScheduleToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :schedule, :text
  end
end
