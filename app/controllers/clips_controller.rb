class ClipsController < ApplicationController

  layout 'in_session', only: [ :index, :show, :new, :decision, :sanction]

  before_action :authorized 

  before_action :set_clip, only: [ :show, :destroy, :decision, :sanction]
  
  def index
    @clips = Clip.all
  end

  def new
    @clip = Clip.new
  end

  def create  
    @clip = Clip.new clip_params
    @clip[ :clipName] = File.basename(params[ :clip][ :video].original_filename, '.mp4').truncate(20)
    @clip[ :uploadUser] = helpers.current_user[ :name]

    # Save clips in DB
    if @clip.save
      flash[ :alert] = 'Successfully uploaded video'
      redirect_to new_clip_path
    else
      flash[ :alert] = c.errors.first.full_message
      redirect_to new_clip_path
    end
  end 

  def show
    if !@clip[ :decision_id].nil?
      @decision = Decision.find(@clip[ :decision_id])
    end
    if !@clip[ :sanction_id].nil?
      @sanction = Sanction.find(@clip[ :sanction_id])
    end
  end

  def destroy
    @clip.destroy
    flash[ :alert] = 'Successfully deleted clip'
    redirect_to clips_path
  end

  def decision
    @decisions = Decision.all
  end

  def change_decision
    #@clip[ :decision_id] = Decision.find_by_description(params[ :clip][ :decision])
    @clip.update(decision_id: Decision.find_by_description(params[ :clip][ :decision])[ :id])
    flash[ :alert] = 'Successfully edited decision'
    redirect_to clip_path
  end

  def sanction
    @sanctions = Sanction.all
  end

  def change_sanction
    @clip.update(sanction_id: Sanction.find_by_description(params[ :clip][ :sanction])[ :id])
    flash[ :alert] = 'Successfully edited sanction'
    redirect_to clip_path
  end

  private 

  def clip_params
    params.require( :clip).permit( :video)
  end

  def set_clip
    @clip = Clip.find params[ :id]
  end

end
