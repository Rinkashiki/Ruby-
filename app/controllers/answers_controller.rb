class AnswersController < ApplicationController

    before_action :authorized

    protect_from_forgery :except => [ :new, :create ]

    def index
        @answers = Answer.all
    end

    def new
        @answer = Answer.new

        respond_to do |format|
            format.js { render layout: false }
        end
    end

    def create
        @answer = Answer.new answer_params

        respond_to do |format|
            format.js { render layout: false }
        end      
    end

    private

    def answer_params
        params.require( :answer).permit( :description, :option)
    end

end
