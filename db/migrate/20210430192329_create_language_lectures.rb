class CreateLanguageLectures < ActiveRecord::Migration[5.2]
  def change
    create_table :languages_lectures, id: false do |t|
      t.belongs_to :language, index: true
      t.belongs_to :lecture, index: true
    end
  end
end
