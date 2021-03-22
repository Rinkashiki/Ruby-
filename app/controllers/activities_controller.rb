class ActivitiesController < ApplicationController

    # Render navigation bar  
    layout 'in_session', only: [ :index, :new, :show, :edit, :destroy, :add_question]

    # Check user is logged
    before_action :authorized

    # Extract the current activity before any method is executed
    before_action :set_activity, only: [ :show, :edit, :update, :destroy, :add_question, :quit_activity_question]

    def index
        @activities = Activity.where(responsible: helpers.current_user[ :name])
    end

    def new
        @activity = Activity.new
    end

    def create

        # Extract only the activities associated with the current user
        aux_activity = Activity.find_by_name(params[ :activity][ :name])
        activities = Activity.where(responsible: helpers.current_user[ :name])

        if !aux_activity.in?(activities)
          @activity = Activity.new activity_params
          @activity[ :initial_date] = Time.now.strftime("%Y-%m-%d")
          @activity[ :final_date] = Time.now.strftime("%Y-%m-%d")
          @activity[ :result_date] = Time.now.strftime("%Y-%m-%d")
          @activity[ :grade] = 5
          @activity[ :responsible] = helpers.current_user[ :name]

          # Save activity in DB
          if @activity.save
            flash[ :alert] = "Succesfully created activity"
            redirect_to activities_path
          else
            flash[ :alert] = @activity.errors.first.full_message
            redirect_to new_activity_path
          end
        else
            flash[ :alert] = "Activity name already used in another existing activity"
            redirect_to new_activity_path
        end    
    end

    def show
        # Extract questions associated with the current activity
        query = "SELECT q.id, q.question, q.question_type FROM questions q JOIN activities_questions aq ON aq.question_id = q.id 
        WHERE aq.activity_id = '#{@activity.id}'"

        @questions = Question.find_by_sql(query)
    end

    def edit
    end

    def update
      @activity.update(initial_date: params[ :activity][ :initial_date], final_date: params[ :activity][ :final_date], 
      result_date: params[ :activity][ :result_date], grade: params[ :activity][ :grade])

      flash[ :alert] = 'Succesfully edited!'

      redirect_to @activity
    end

    def destroy
    @activity.destroy
    flash[ :alert] = 'Successfully deleted activity'
    redirect_to activities_path
    end

    def quit_activity_question
      @question = Question.find params[ :question]

      query = "DELETE from activities_questions WHERE activity_id = '#{@activity.id}' AND question_id = '#{@question.id}'"
      ActiveRecord::Base.connection.exec_query(query)
    
      flash[ :alert] = 'Successfully quit question'
    
      redirect_to activity_path

    end

    private 

    def activity_params
        params.require( :activity).permit( :name)
    end

    def set_activity
        @activity = Activity.find params[ :id]
    end

end
