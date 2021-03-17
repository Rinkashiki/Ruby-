class AnswersController < ApplicationController

    layout 'in_session', only: [ :new]

    before_action :authorized

    before_action :set_question, only: [ :new, :create, :destroy]

    #protect_from_forgery :except => [ :new, :create ]

    def index
        @answers = Answer.all
    end

    def new
        @answer = Answer.new

        @question = Question.find params[ :question]

        if !params[ :clip].nil?
          @clip = Clip.find params[ :clip]
        end

        #respond_to do |format|
            #format.js { render layout: false }
        #end
    end

    def create
        @answer = Answer.new answer_params

        @answer[ :question_id] = params[ :question]

        if !params[ :clip].nil?
            @clip = Clip.find params[ :clip]
        end

        #@question = Question.find(params[ :question])

        if @answer.save
            flash[ :alert] = "Succesfully created answer"
            if !@clip.nil?
              redirect_to @clip
            else
              redirect_to @question
            end
        else
            flash[ :alert] = @answer.errors.first.full_message
            if !@clip.nil?
              redirect_to new_answer_path(question: params[ :question], clip: params[ :clip])
            else
              redirect_to new_answer_path(question: params[ :question])
            end
        end

        #respond_to do |format|
            #format.js { render layout: false }
        #end      
    end

    def show
    end

    def destroy

        if !params[ :clip].nil?
            @clip = Clip.find params[ :clip]
        end

        @answer = Answer.find params[ :id]
        @answer.destroy
        flash[ :alert] = 'Successfully deleted answer'

        if !@clip.nil?
          redirect_to @clip
        else
          redirect_to @question
        end

    end

    private

    def answer_params
        params.require( :answer).permit( :description, :option)
    end

    def set_question
        @question = Question.find(params[ :question])
    end

end
