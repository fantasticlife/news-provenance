class CreateSourceSimilarities < ActiveRecord::Migration
  def change
    create_table :source_similarities do |t|

      t.timestamps null: false
    end
  end
end
