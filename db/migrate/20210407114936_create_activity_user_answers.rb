class CreateActivityUserAnswers < ActiveRecord::Migration[6.1]
    def change
      create_table :activity_user_answers do |t|
        t.references :activities_users, null: false, foreign_key: true
        t.references :answer, null: false, foreign_key: true
  
        t.timestamps
      end
    end
  end
  