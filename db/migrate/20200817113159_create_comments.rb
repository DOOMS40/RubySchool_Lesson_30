class CreateComments < ActiveRecord::Migration[6.0]
  def change
  	create_table :comments do |t|
  		t.text :message
  		t.text :datestamp

  		t.timestamps
  	end
  end
end
