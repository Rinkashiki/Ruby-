class CreateActivityUserAnswers < ActiveRecord::Migration[6.1]
    def change
      create_table :activity_user_answers do |t|
        t.references :activities_users, null: false, foreign_key: true
        t.references :answer, null: true, foreign_key: true
        t.references :decision, null: true, foreign_key: true
        t.references :sanction, null: true, foreign_key: true
        t.text :open_question, null: true
  
        t.timestamps
      end
    end
  end
  