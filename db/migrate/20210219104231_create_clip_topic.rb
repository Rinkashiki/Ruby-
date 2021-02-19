class CreateClipTopic < ActiveRecord::Migration[6.1]
  def change
    create_table :clip_topic do |t|
      t.references :clips, null: false, foreign_key: true
      t.references :topics, null: false, foreign_key: true

      t.timestamps
    end
  end
end
