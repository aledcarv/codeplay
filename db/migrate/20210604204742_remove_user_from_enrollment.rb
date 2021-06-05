class RemoveUserFromEnrollment < ActiveRecord::Migration[6.1]
  def change
    remove_reference :enrollments, :user, null: false, foreign_key: true
  end
end
