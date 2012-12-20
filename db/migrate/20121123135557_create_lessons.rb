class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.string :status
      t.references :student, null: false
      t.references :teacher, null: false

      t.timestamps
    end
    add_index :lessons, :student_id
    add_index :lessons, :teacher_id
  end
end
