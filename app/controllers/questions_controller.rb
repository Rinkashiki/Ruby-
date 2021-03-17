class QuestionsController < ApplicationController

    layout 'in_session', only: [ :index, :new, :show]

    before_action :authorized

    before_action :set_question, only: [ :show, :add_activity_question]

    def index
        @questions = Question.all
    end

    def new

        if !params[ :activity].nil?
          @activity = Activity.find params[ :activity]

          query = "SELECT id, question, question_type from questions except 
          SELECT q.id, q.question, q.question_type from questions q join activities_questions aq on 
          q.id = aq.question_id where aq.activity_id = '#{@activity.id}'"
  
          @questions = Question.find_by_sql(query)

          @clips = Clip.all

          @evaluated_clips = Clip.where.not(decision_id: nil, sanction_id: nil)

        else 
          @questions = Question.where(question_type: "Trivia")
        end

        @question = Question.new 

        @type = params[ :type]

        if !params[ :clip].nil?
          @clip = params[ :clip]
        end

        #respond_to do |format|
            #format.html
            #format.js
        #end
    end

    def create

      # Access from activity
      if !params[ :activity].nil?
        @activity = Activity.find params[ :activity]
      end

      # Access from clip
      if !params[ :clip].nil?
        @clip = Clip.find params[ :clip]
      end

      if params[ :type] == "Video Test"
        @question = Question.new(question: "Video Test")
      else
        @question = Question.new question_params
      end

        if params[ :type].nil?
          @question[ :question_type] = "Trivia"
        else
          @question[ :question_type] = params[ :type]
        end

        if !@clip.nil?
          @question[ :clip_id] = params[ :clip]

          if @question[ :question_type] != "Video Test"
            @question[ :question_type] = "Video Trivia" 
          end
        end
        
        if @question.save
            flash[ :alert] = "Succesfully created question"
            if !params[ :activity].nil?
              query = "INSERT into activities_questions (activity_id, question_id, created_at, updated_at) 
              values ('#{@activity.id}', '#{@question.id}', now(), now())"
              ActiveRecord::Base.connection.exec_query(query)

              redirect_to @activity
            else
              @clip.update(question_id: @question[ :id])

              redirect_to @clip
            end
        else
            flash[ :alert] = @question.errors.first.full_message
            if !params[ :activity].nil?
              redirect_to new_question_path(activity: params[ :activity], type: params[ :type])
            else
              redirect_to new_question_path(clip: params[ :clip], type: params[ :type])
            end
        end
        
        #respond_to do |format|
        #format.js {render layout: false, content_type: 'text/javascript'}
        #format.html
      #end

    end

    def show
        #@question = Question.find params[ :id]

        @answers = Answer.where(question_id: @question[ :id])

        if !@question[ :clip_id].nil?
          @clip = Clip.find(@question[ :clip_id])

          if !@clip[ :decision_id].nil?
            @decision = Decision.find(@clip[ :decision_id])
          end
          if !@clip[ :sanction_id].nil?
            @sanction = Sanction.find(@clip[ :sanction_id])
          end
        end
    end

    def add_activity_question

      @activity = Activity.find params[ :activity]

      query = "INSERT into activities_questions (activity_id, question_id, created_at, updated_at) 
      values ('#{@activity.id}', '#{@question.id}', now(), now())"

      ActiveRecord::Base.connection.exec_query(query)

      flash[ :alert] = 'Successfully added question'
      redirect_to @activity

    end

    private

    def question_params
        params.require( :question).permit( :question)
    end

    def set_question
      @question = Question.find params[ :id]
    end
end
