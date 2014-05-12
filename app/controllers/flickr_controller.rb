class FlickrController < ApplicationController
  require 'open-uri'

  def search
    url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{FLICKR_API_KEY}&tags=#{URI.escape(params[:q].gsub(' ', ','))}&safe_search=1&per_page=20"

    page = Nokogiri::XML(open(url))
    @photos = page.xpath('//photo')
  end
end
