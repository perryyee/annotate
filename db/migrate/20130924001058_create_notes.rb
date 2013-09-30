class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.string :time
      t.string :url
      t.string :content

      t.timestamps
    end
  end
end
