require 'rails_helper'
require 'fakefs/spec_helpers'

RSpec.describe 'Point checks API', type: :request do
  include FakeFS::SpecHelpers

  # a point known to be inside one of the stubbed areas
  let(:point) {{
    point: {
      type: 'Point', coordinates: [9.20581641800003, 50.715466625164694]
    }
  }}

  before do
    stub_given_areas
    post '/point_checks', params: point.to_json, headers: base_headers
  end

  describe 'POST /point_checks' do
    context 'when the given point is inside any of the given areas' do  
      it 'reports true' do
        expect(response).to have_http_status(201)
        expect(json['inside?']).to be_truthy
      end
    end

    context 'when the given point is not inside any of the given areas' do  
      # a point known to be outside the stubbed areas
      let(:point) {{
        point: {
          type: 'Point', coordinates: [90, 180]
        }
      }}

      it 'reports false' do
        expect(response).to have_http_status(201)
        expect(json['inside?']).to be_falsey
      end
    end

    context 'when the point is unparseable' do
      # an invalid point
      let(:point) {{
        point: {
          type: 'InvalidPoint', coordinates: nil
        }
      }}

      it 'returns an error' do
        expect(response).to have_http_status(400)
        expect(json['error']).to eq('Invalid GeoJSON point')
      end
    end
  end
end