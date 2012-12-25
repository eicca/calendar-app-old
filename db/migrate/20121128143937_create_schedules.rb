class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :teacher
      t.string :title

      t.datetime :start_at
      t.datetime :end_at

      t.integer :minutes_before_start
      t.integer :minutes_before_end

      t.boolean :recurring

      t.timestamps
    end
    add_index :schedules, :teacher_id
  end
end
