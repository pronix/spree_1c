class Api::Admin::TaxonsController < Api::BaseController
  before_filter :load_taxon, :only => [ :update, :destroy ]

  def create
    @taxonomy = Taxonomy.find_or_create_by_name "Categories"
    @root_taxon = @taxonomy.taxons.roots.find_or_create_by_name "Categories"
    @taxon = Taxon.create( ({ "parent_id" => @root_taxon.id,  :taxonomy_id => @taxonomy.id  }).merge(params[:taxon]) )
    render :xml => @taxon.to_xml
  end

  def update
    if @taxon.update_attributes(params[:taxon])
      render :xml => { :result => :ok }.to_xml
    else
      render :xml => { :result => :error, :messages => @taxon.errors }.to_xml
    end
  end

  def destroy
    if @taxon.destroy
      render :xml => { :result => :ok }.to_xml
    else
      render :xml => { :result => :error, :messages => @taxon.errors }.to_xml
    end
  end

  private
  def load_taxon
    unless (@taxon = Taxon.find_by_id params[:id])
      render :xml => { :result => :error, :messages => "Taxon not found" }.to_xml and return
    end

  end
end
