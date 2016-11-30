class CreateExtractedEntities < ActiveRecord::Migration
  def change
    create_table :extracted_entities do |t|

      t.timestamps null: false
    end
  end
end
