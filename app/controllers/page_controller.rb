class PageController < ApplicationController
  def index
    @federal_states = FederalState.all
    @years = Year.where(value: (Date.today.year)..Year.maximum(:value)).order(:value).limit(10)

    # Caching
    #
    expires_in (Time.now.end_of_month - Time.now).to_i.seconds, public: true
    last_update = [Year.maximum(:updated_at), FederalState.maximum(:updated_at)].sort.last.utc
    fresh_when last_modified: last_update, etag: Digest::MD5.hexdigest(last_update.to_s)
  end

  def about_us
    @federal_states = FederalState.all

    # Caching
    #
    expires_in (Time.now.end_of_month - Time.now).to_i.seconds, public: true
    last_update = FederalState.maximum(:updated_at).utc
    fresh_when last_modified: last_update, etag: Digest::MD5.hexdigest(last_update.to_s)
  end
end
