class SanctionsController < ApplicationController

    layout 'in_session', only: [ :index]

    def index
        @sanctions = Sanction.all
    end

end
