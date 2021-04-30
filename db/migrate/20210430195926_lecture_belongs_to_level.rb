class LectureBelongsToLevel < ActiveRecord::Migration[5.2]
  def change
    add_reference :lectures, :level, index: true
  end
end
