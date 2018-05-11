class CreateProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :problems do |t|
      t.integer :minuend, :subtrahend, :success_times, :user_id
      t.timestamps
    end
  end
end
