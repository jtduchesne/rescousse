module StubApiHelper
  def stub_google_maps(opts = {})
    stub_google_maps_with(FactoryBot.create(:place_details_hash), opts)
  end
  def stub_google_maps_with(place_details_hash, opts = {})
    stub_request(:get, /maps.googleapis.com/).to_return({
      status: opts[:status] || 200,
      body: place_details_hash.to_json
    })
  end
end
