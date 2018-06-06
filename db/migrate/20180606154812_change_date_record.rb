class ChangeDateRecord < ActiveRecord::Migration[5.1]
  def change
    rename_column :date_records, :minutes, :seconds

    change_column_default :date_records, :seconds, 0
    change_column_default :date_records, :problems_answered, 0
    change_column_default :date_records, :facts_mastered, 0
  end
end
