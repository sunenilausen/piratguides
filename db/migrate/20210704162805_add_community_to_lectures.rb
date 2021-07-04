class AddCommunityToLectures < ActiveRecord::Migration[6.1]
  def change
    add_column :lectures, :community, :boolean, default: :true
  end
end
