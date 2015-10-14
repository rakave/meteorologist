require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.forecast.io/forecast/078309d583a0085378cfa9000d3a869c/#{@lat},#{@lng}"

    @current_temperature = JSON.parse(open(url).read)["currently"]["temperature"]

    @current_summary = JSON.parse(open(url).read)["currently"]["summary"]

    @summary_of_next_sixty_minutes = JSON.parse(open(url).read)["minutely"]["summary"]

    @summary_of_next_several_hours = JSON.parse(open(url).read)["hourly"]["summary"]

    @summary_of_next_several_days = JSON.parse(open(url).read)["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
