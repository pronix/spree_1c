class Api::Admin::ProductsController < Api::BaseController
  before_filter :load_product, :only => [ :update, :destroy ]

  def create
    @product = Product.last
    render :xml => @product.to_xml
  end

  def update
    if @product.update_attributes(params[:product])
      render :xml => { :result => :ok }.to_xml
    else
      render :xml => { :result => :error, :messages => @product.errors }.to_xml
    end
  end

  def destroy
    if @product.destroy
      render :xml => { :result => :ok }.to_xml
    else
      render :xml => { :result => :error, :messages => @product.errors }.to_xml
    end

  end

  private
  def load_product

    unless (@product = Product.find_by_id params[:id])
      render :xml => { :result => :error, :messages => "Product not found" }.to_xml and return
    end

  end
end
