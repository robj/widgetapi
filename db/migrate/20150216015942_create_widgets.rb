class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :supplier
      t.integer :cost

      t.timestamps
    end
  end
end
