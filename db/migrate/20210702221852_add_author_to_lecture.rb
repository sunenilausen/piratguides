class AddAuthorToLecture < ActiveRecord::Migration[6.1]
  def change
    change_table :lectures do |t|
      t.references :author
    end
  end

  def up
    Lecture.all.update_all(author_id: User.first.id)
  end
end
