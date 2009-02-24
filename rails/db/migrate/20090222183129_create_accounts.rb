class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      
      t.timestamps
    end
    
    add_column :users, :account_id, :integer
  end

  def self.down
    drop_table :accounts
  end
end
