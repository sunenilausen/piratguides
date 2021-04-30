class CreateLectureTools < ActiveRecord::Migration[5.2]
  def change
    create_table :lectures_tools, id: false do |t|
      t.belongs_to :lecture, index: true
      t.belongs_to :tool, index: true
    end
  end
end
