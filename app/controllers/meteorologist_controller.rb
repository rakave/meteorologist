require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
end

def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url1 = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    @lat = JSON.parse(open(url1).read)["results"][0]["geometry"]["location"]["lat"]

    @lng = JSON.parse(open(url1).read)["results"][0]["geometry"]["location"]["lng"]

    url2 = "https://api.forecast.io/forecast/078309d583a0085378cfa9000d3a869c/#{@lat},#{@lng}"

    @current_temperature = JSON.parse(open(url2).read)["currently"]["temperature"]

    @current_summary = JSON.parse(open(url2).read)["currently"]["summary"]

    @summary_of_next_sixty_minutes = JSON.parse(open(url2).read)["minutely"]["summary"]

    @summary_of_next_several_hours = JSON.parse(open(url2).read)["hourly"]["summary"]

    @summary_of_next_several_days = JSON.parse(open(url2).read)["daily"]["summary"]

    render("street_to_weather.html.erb")
end
end
