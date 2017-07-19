class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
    	t.string :title
    	t.string :first_name
    	t.string :last_name
    	t.string :road
    	t.string :postcode
    	t.string :town
    	t.string :country
    	t.string :email
    	t.string :telephone
    	t.integer :free_tickets
    	t.integer :order_id
    	t.string :slug
      t.timestamps
    end
  end
end
