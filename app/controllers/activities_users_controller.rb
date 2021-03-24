class ActivitiesUsersController < ApplicationController

    # Render navigation bar  
    layout 'in_session', only: [ :index]

    def index
        query = "SELECT * from activities a JOIN activities_users au ON a.id = au.activity_id 
        where '#{helpers.current_user[ :id]}' = au.user_id"
  
        @activities = Activity.find_by_sql(query)
      end

end