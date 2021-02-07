class ImagesController < ApplicationController

  $crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY'])
 
  before_action :set_image, only: [ :show, :edit, :update, :destroy]

  def index
    @images = Image.all
    @images.each do |image|
      image.description = $crypt.decrypt_and_verify(image.description)
    end
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new image_params
    #crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY'])
    @image.description = $crypt.encrypt_and_sign(@image.description)
    @image.save

    redirect_to @image
  end

  def show
    #crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY'])
    @image.description = $crypt.decrypt_and_verify(@image.description)
  end

  def edit
    @image.description = $crypt.decrypt_and_verify(@image.description)
  end

  def update
    @image.update(description: $crypt.encrypt_and_sign(image_params[ :description]))

    redirect_to images_path
  end   

  def destroy
    @image.destroy

    redirect_to images_path
  end

  private

  def image_params
    params.require(:image).permit(:description)
  end

  def set_image
    @image = Image.find params[:id]
  end
  
end
