class AddLabsToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :for_lab, :string
  end
end
