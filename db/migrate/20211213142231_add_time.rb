class AddTime < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :time, :datetime
  end
end
