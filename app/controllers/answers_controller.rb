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

        #@question = Question.find params[ :question]

        #respond_to do |format|
            #format.js { render layout: false }
        #end
    end

    def create
        @answer = Answer.new answer_params

        @answer[ :question_id] = params[ :question]

        #@question = Question.find(params[ :question])

        if @answer.save
            flash[ :alert] = "Succesfully created answer"
            redirect_to @question
        else
            flash[ :alert] = @answer.errors.first.full_message
            redirect_to new_answer_path
        end

        #respond_to do |format|
            #format.js { render layout: false }
        #end      
    end

    def show
    end

    def destroy
        @answer = Answer.find params[ :id]
        @answer.destroy
        flash[ :alert] = 'Successfully deleted answer'
        redirect_to @question
    end

    private

    def answer_params
        params.require( :answer).permit( :description, :option)
    end

    def set_question
        @question = Question.find(params[ :question])
    end

end
