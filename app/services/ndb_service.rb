class NdbService
  def self.conn
    Faraday.new(:url => "http://api.nal.usda.gov") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  FOODS = {"Burger King Cheeseburger" => 21251,
           "CHICK-FIL-A chicken sandwich" => 21526}

  def self.calories(food)
    food_id = FOODS[food]
    response = conn.get "/ndb/nutrients/?format=json&api_key=#{ENV['NBD_API_KEY']}&nutrients=208&ndbno=#{food_id}"
    JSON.parse(response.body)["report"]["foods"][0]["nutrients"][0]["value"]
  end

  def self.sugars(food)
    food_id = FOODS[food]
    response = conn.get "/ndb/nutrients/?format=json&api_key=#{ENV['NBD_API_KEY']}&nutrients=269&ndbno=#{food_id}"
    JSON.parse(response.body)["report"]["foods"][0]["nutrients"][0]["value"]
  end

  def self.fat(food)
    food_id = FOODS[food]
    response = conn.get "/ndb/nutrients/?format=json&api_key=#{ENV['NBD_API_KEY']}&nutrients=204&ndbno=#{food_id}"
    JSON.parse(response.body)["report"]["foods"][0]["nutrients"][0]["value"]
  end
end
