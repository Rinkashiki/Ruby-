class ActivitiesUsersController < ApplicationController

    # Render navigation bar  
    layout 'in_session', only: [ :index, :finish_activity]

    # Check user is logged
    before_action :authorized 

    skip_before_action :verify_authenticity_token, only: [ :doing_activity_post]

    # Extract the current activity before any method is executed
    before_action :set_activity, only: [ :doing_activity, :doing_activity_post, :finish_activity]

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

      def doing_activity_post

        # Save user answer

        # Extract question count 
        query = "SELECT q.* FROM questions q JOIN activities_questions aq ON q.id = aq.question_id 
        where aq.activity_id = '#{@activity[ :id]}'"
        questions = Question.find_by_sql(query)

        total_questions = questions.length()

        @n_question = params[ :n_question].to_i

        # Extract the activity_user entry
        query = "SELECT * from activities_users WHERE activity_id = '#{@activity[ :id]}' 
        AND user_id = '#{helpers.current_user[ :id]}'"

        activity_user = ActiveRecord::Base.connection.exec_query(query).rows
    
        # Save the answer associated with the activity and the user in DB
        query = "INSERT into activity_user_answers (activities_users_id, answer_id, created_at, updated_at) 
        values ('#{activity_user[0][0]}', '#{params[ :user_answer]}', now(), now())"

        ActiveRecord::Base.connection.exec_query(query)

        if @n_question < total_questions - 1 
          redirect_to doing_activity_path(activity: @activity.id, n_question: @n_question + 1)
        else
          redirect_to finish_activity_path(activity: @activity.id)
        end

      end

      def finish_activity

        # Extract questions
        query = "SELECT q.* from questions q JOIN activities_questions aq ON q.id = aq.question_id 
        where aq.activity_id = '#{@activity[ :id]}'"
        
        @questions = Question.find_by_sql(query)

        # Extract the answers from activity_user_answers 
        query = "SELECT a.* FROM answers a JOIN (SELECT aua.* FROM activity_user_answers aua JOIN activities_users au
         ON aua.activities_users_id = au.id WHERE au.activity_id = '#{@activity[ :id]}' AND 
         au.user_id = '#{helpers.current_user[ :id]}') AS x ON a.id = x.answer_id"

        @user_answers = Answer.find_by_sql(query)

      end

      private 

      def set_activity
        @activity = Activity.find params[ :activity]
      end

end