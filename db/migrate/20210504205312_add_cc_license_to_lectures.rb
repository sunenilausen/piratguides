class AddCcLicenseToLectures < ActiveRecord::Migration[6.1]
  def change
    add_column :lectures, :cc_license, :boolean, default: :true
  end
end
