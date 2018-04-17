class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|

      t.belongs_to :user
      t.string :name
      t.date :start_time
      t.date :end_time
      t.string :rule
      t.string :information

      t.timestamps
    end
  end
end
