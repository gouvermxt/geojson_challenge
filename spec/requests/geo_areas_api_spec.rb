require 'rails_helper'
require 'fakefs/spec_helpers'

RSpec.describe 'Geo Areas API', type: :request do
  include FakeFS::SpecHelpers

  def stub_given_areas
    stub = Rails.root.join('spec/fixtures/files/Given_areas.json')
    destination = Rails.root.join('app/services/Given_areas.json')
    FileUtils.remove_entry_secure(destination)
    FileUtils.cp_r(stub, destination)
    stub.read
  end

  describe 'GET /geo_areas' do
    it 'returns all the geo areas from the file' do
      FakeFS::FileSystem.clone(Rails.root)
      areas_stub = stub_given_areas
      areas_stub_json = JSON.parse(areas_stub)

      get '/geo_areas' 

      expect(response).to have_http_status(200)
      expect(json).to eq(areas_stub_json)
    end
  end
end