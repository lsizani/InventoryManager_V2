class AddIndexesToRequests < ActiveRecord::Migration
  def change
    add_index :reagents, :id
    add_index :orders, :id
  end
end
