class DecisionsController < ApplicationController

    layout 'in_session', only: [ :index]

    def index
        @decisions = Decision.all
    end

end
