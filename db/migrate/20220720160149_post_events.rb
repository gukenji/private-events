class PostEvents < ActiveRecord::Migration[7.0]
  def change   
    create_table :attendees_events do |t|

      t.timestamps
    end   
  end
end
