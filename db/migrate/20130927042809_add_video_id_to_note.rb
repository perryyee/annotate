class AddVideoIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :video_id, :integer
  end
end
