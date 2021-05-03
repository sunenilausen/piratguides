class AddPrintableAndSlidesToLectures < ActiveRecord::Migration[6.1]
  def change
    add_column :lectures, :printable, :boolean, default: false
    add_column :lectures, :slides, :boolean, default: false
  end
end
