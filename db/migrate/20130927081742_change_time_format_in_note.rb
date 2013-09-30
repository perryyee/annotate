class ChangeTimeFormatInNote < ActiveRecord::Migration
	def change
		change_column :notes, :time, :float
	end
end
