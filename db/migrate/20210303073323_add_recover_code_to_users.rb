class AddRecoverCodeToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :recover_code, :string
  end
end
