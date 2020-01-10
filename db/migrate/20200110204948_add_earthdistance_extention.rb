class AddEarthdistanceExtention < ActiveRecord::Migration[5.2]
  def change
    execute "CREATE EXTENSION cube;"
    execute "CREATE EXTENSION earthdistance;"
  end
end
