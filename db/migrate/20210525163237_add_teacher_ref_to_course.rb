class AddTeacherRefToCourse < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :teacher, null: false, foreign_key: true
  end
end
