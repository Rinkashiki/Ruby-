class EvaluationController < ApplicationController

    # Render navigation bar  
    layout 'in_session', only: [ :index]

    # Check user is logged
    before_action :authorized

    def index
        @activities = Activity.all
    end

    def results
        
    end

    private

    def set_activity
        @activity = Activity.find params[ :activity]
    end

end