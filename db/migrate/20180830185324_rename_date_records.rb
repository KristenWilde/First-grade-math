class RenameDateRecords < ActiveRecord::Migration[5.1]
  def change
    rename_table :date_records, :practice_dates
  end
end
