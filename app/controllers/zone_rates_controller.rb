class ZoneRatesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user.company.company_zones.size > 0
      @company_zone = current_user.company.company_zones.first
    end
  end
  
  def create
    params[:hash].each do |k,v|
      ZoneRate.create(:vehicle_type_id=>k,:zone_rate=>v,:destination_id=>params[:destination_id],:source_id=>params[:source_id])
    end
  end
  
  def find_zone_rate
    zone_rates = ZoneRate.where(:destination_id=>params[:destination_id],:source_id=>params[:source_id])
    if zone_rates.size > 0
      render :json => {'status'=>'success','zone_rates'=>zone_rates}
    else
      render :json => {'status'=>"failure"}
    end
  end
end
