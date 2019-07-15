require 'rails_helper'
require 'fakefs/spec_helpers'

RSpec.describe 'Geo Areas API', type: :request do
  include FakeFS::SpecHelpers

  describe 'GET /geo_areas' do
    it 'returns all the given geo areas' do
      areas_stub = stub_given_areas
      areas_stub_json = JSON.parse(areas_stub)

      get '/geo_areas' 

      expect(response).to have_http_status(200)
      expect(json).to eq(areas_stub_json)
    end
  end
end