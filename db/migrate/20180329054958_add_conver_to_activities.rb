class AddConverToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :cover, :string
  end
end
