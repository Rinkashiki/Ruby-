class ActivitiesUsersController < ApplicationController

    # Render navigation bar  
    layout 'in_session', only: [ :index]

    # Extract the current activity before any method is executed
    before_action :set_activity, only: [ :doing_activity]

    def index
        query = "SELECT a.* from activities a JOIN activities_users au ON a.id = au.activity_id 
        where '#{helpers.current_user[ :id]}' = au.user_id"
  
        @activities = Activity.find_by_sql(query)
      end

      def doing_activity

        # For all questions
        query = "SELECT q.* from questions q JOIN activities_questions aq ON q.id = aq.question_id 
        where aq.activity_id = '#{@activity[ :id]}'"
        questions = Question.find_by_sql(query)

        @n_question = params[ :n_question].to_i

        @total_questions = questions.length()
        
        @question = questions[@n_question] 

        @type = @question[ :question_type]

        # Extract answers of the current question
        @answers = Answer.where(question_id: @question.id)

        # For Video Trivia and Video Test
        if !@question.clip_id.nil?
          @clip = Clip.find(@question.clip_id)
        end

      end

      private 

      def set_activity
        @activity = Activity.find params[ :activity]
      end

end