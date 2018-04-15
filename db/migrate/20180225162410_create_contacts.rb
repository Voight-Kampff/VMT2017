class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|

    	t.string :first_name
    	t.string :last_name

    	t.string :email
		t.integer :telephone

		t.string :number
		t.string :road
		t.string :town
		t.string :postal_code
		t.string :country

		t.timestamps

	end

	create_table :tags do |t|

		t.string :name

    	t.timestamps

    end

	create_table :contact_tags do |t|

		t.belongs_to :contact, index: true
		t.belongs_to :tag, index: true

		t.timestamps
		
	end
  end
end
