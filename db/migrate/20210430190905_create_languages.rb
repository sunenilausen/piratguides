class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :title
      t.integer :number

      t.timestamps
    end
  end
end
