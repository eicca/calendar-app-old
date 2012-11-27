class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.time :duration, null: false
      t.datetime :start_at, null: false
      t.boolean :completed, default: false
      t.references :student, null: false
      t.references :teacher, null: false

      t.timestamps
    end
    add_index :lessons, :student_id
    add_index :lessons, :teacher_id
  end
end
