class FlickrController < ApplicationController
  require 'open-uri'

  def search

    # Tags for search
    tags = URI.escape(params[:q].mb_chars.downcase.to_s.gsub(' ', ','))

    # Flickr url
    url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{FLICKR_API_KEY}&tags=#{tags}&safe_search=1&per_page=20"

    # Get xml flickr photo
    xml = Rails.cache.fetch("flickr_search_#{tags}") { open(url).read }

    photos = Nokogiri::XML(xml)

    @photos = photos.xpath('//photo')
  end
end
