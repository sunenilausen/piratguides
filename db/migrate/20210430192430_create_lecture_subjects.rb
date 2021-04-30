class CreateLectureSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :lectures_subjects, id: false do |t|
      t.belongs_to :lecture, index: true
      t.belongs_to :subject, index: true
    end
  end
end
