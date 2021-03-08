class QuestionsController < ApplicationController

    before_action :authorized

    def index
        @questions = Answer.all
    end

    def new
        @question = Answer.new

        respond_to do |format|
            format.js
        end
    end

    def create
        @question = Question.new answer_params

        respond_to do |format|
            format.js
        end      
    end

    private

    def question_params
        params.require( :question).permit( :question)
    end
end
