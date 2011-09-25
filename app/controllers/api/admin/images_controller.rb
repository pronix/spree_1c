class Api::Admin::ImagesController < Api::BaseController
  before_filter :prepare_params

  def create

    params[:image][:viewable_id] = params[:product_id]
    params[:image][:viewable_type ]= "Product"

    @image = Image.create!(params[:image])
    render :xml => @image.to_xml
  end

  def update
    if (@image = Image.find_by_id(params[:id]))

      if @image.update_attributes(params[:image])
        render :xml => @image.to_xml
      else
        render :xml => { :result => :error, :messages => @image.errors }.to_xml
      end
    else
      @image = Image.create!(params[:image])
      render :xml => @image.to_xml
    end
  end

  def destroy
    @image = Image.find_by_id(params[:id])
    if @image && @image.destroy
      render :xml => { :result => :ok }.to_xml
    else
      render :xml => { :result => :error, :messages => @image.errors }.to_xml
    end

  end

  private
  def prepare_params
    @_image = request.raw_post.split('&').detect{ |v|
      v =~ /^image\[attachment\]/ }.gsub("image[attachment]=", '').gsub("\r\r\n", '') rescue nil
    if params[:image] && params[:image][:attachment] && @_image
      boundary = ActiveSupport::SecureRandom.hex.upcase
      file = Tempfile.new(boundary)
      file <<  ActiveSupport::Base64.decode64(@_image)
      params[:image][:attachment] = file
    end
  end

  def load_resource

  end
end
