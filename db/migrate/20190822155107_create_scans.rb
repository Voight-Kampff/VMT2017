class CreateScans < ActiveRecord::Migration[5.0]
  def change
    create_table :scans do |t|

    	t.integer	:reservation_id
    	t.integer	:scanner_user_id
    	t.boolean	:status
    	t.string	:message

    	t.timestamps
    end
  end
end
