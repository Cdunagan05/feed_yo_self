require 'oauthenticator'

class CompareController < ApplicationController
  def index
    # response = Faraday.get "http://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=#{ENV['NBD_API_KEY']}&nutrients=204&nutrients=208&ndbno=21251"
    # parsed = JSON.parse(response.body)
    # calories = parsed["report"]["foods"][0]["nutrients"][0]["value"]
    @calories = NdbService.calories(params["q"])
    @sugars = NdbService.sugars(params["q"])
    @fats = NdbService.fat(params["q"])
  end
end
