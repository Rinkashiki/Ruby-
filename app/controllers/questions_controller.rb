class QuestionsController < ApplicationController

    layout 'in_session', only: [ :index, :new]

    before_action :authorized

    def index
        @questions = Question.all
    end

    def new
        @questions = Question.all

        @question = Question.new

        @clips = Clip.all

        @evaluated_clips = Clip.where.not(decision_id: nil, sanction_id: nil)

        @type = params[ :type]

        if !params[ :activity].nil?
          @activity = params[ :activity]
        end

        if !params[ :clip].nil?
          @clip = params[ :clip]
        end

        respond_to do |format|
            format.html
            format.js
        end
    end

    def create
        @question = Question.new question_params

        respond_to do |format|
            format.js
        end     
        
        #respond_to do |format|
        #format.js {render layout: false, content_type: 'text/javascript'}
        #format.html
      #end

    end

    private

    def question_params
        params.require( :question).permit( :question)
    end
end
