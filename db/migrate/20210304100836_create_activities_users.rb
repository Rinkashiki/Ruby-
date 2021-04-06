class CreateActivitiesUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :activities_users do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :answers, array: true, default: []

      t.timestamps
    end
  end
end
