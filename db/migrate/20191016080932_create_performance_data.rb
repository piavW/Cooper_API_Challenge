class CreatePerformanceData < ActiveRecord::Migration[5.2]
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS hstore'
    create_table :performance_data do |t|
      t.references :user, index: true, foreign_key: true
      t.hstore :data

      t.timestamps null: false
    end
  end
end