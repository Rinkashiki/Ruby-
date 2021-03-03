class AddClipIdToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :clip, null: false, foreign_key: true
  end
end
