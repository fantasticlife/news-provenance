class CreateSourceEntitySentiments < ActiveRecord::Migration
  def change
    create_table :source_entity_sentiments do |t|

      t.timestamps null: false
    end
  end
end
