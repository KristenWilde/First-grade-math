class CreateDateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :date_records do |t|
      t.integer :minutes, :problems_answered, :facts_mastered, :user_id
      t.timestamps
    end
  end
end
