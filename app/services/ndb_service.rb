class NdbService
  def self.conn
    Faraday.new(:url => "http://api.nal.usda.gov") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.calories
    response = conn.get "/ndb/nutrients/?format=json&api_key=#{ENV['NBD_API_KEY']}&nutrients=208&ndbno=21251"
    JSON.parse(response.body)["report"]["foods"][0]["nutrients"][0]["value"]
  end

  def self.sugars
    response = conn.get "/ndb/nutrients/?format=json&api_key=#{ENV['NBD_API_KEY']}&nutrients=269&ndbno=21251"
    JSON.parse(response.body)["report"]["foods"][0]["nutrients"][0]["value"]
  end

  def self.fat
    response = conn.get "/ndb/nutrients/?format=json&api_key=#{ENV['NBD_API_KEY']}&nutrients=204&ndbno=21251"
    JSON.parse(response.body)["report"]["foods"][0]["nutrients"][0]["value"]
  end
end
