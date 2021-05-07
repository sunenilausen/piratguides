class AddLicenseToLectures < ActiveRecord::Migration[6.1]
  def change
    add_column :lectures, :license, :text
  end
end
