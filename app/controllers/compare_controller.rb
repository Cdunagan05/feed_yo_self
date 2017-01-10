require 'oauthenticator'

class CompareController < ApplicationController
  def index
    sig_options = {
      :signature_method => 'HMAC-SHA1',
      :consumer_key => "#{ENV['FAT_SECRET_API_KEY']}",
      :consumer_secret => "#{ENV['FAT_SECRET_SHARED_SECRET']}",
      # :oauth_timestamp => "#{DateTime.now}",
      # :oauth_nonce => "#{SecureRandom.hex}",
      # :oauth_version => "1.0",
    }

    connection = Faraday.new('http://platform.fatsecret.com/') do |faraday|
      faraday.request :url_encoded
      # faraday.params
      faraday.request :oauthenticator_signer, sig_options
      faraday.adapter Faraday.default_adapter
    end

    response = connection.get "rest/server.api?food_id=33791&method=food.get"
    byebug
    parsed = JSON.parse(response)
  end
end

# &oauth_signature_method=HMAC-SHA1&oauth_consumer_key=#{ENV['FAT_SECRET_API_KEY']}&oauth_nonce=#{SecureRandom.hex}&oauth_timestamp=#{DateTime.now}
