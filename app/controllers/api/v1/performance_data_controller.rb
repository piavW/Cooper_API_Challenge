class Api::V1::PerformanceDataController < ApplicationController
  def create
    @data = PerformanceData.new(performance_data_params)
    if @data.save
      render json: { message: 'all good' }
    else 
      render json: { error: @data.errors.full_messages }
    end
  end

  private
  def performance_data_params
    params.require(:performance_data).permit!
  end
end