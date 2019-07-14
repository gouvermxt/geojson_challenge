require 'rgeo/geo_json'

# Reads the list of geographical areas in GeoJSON format
class GeoAreas
  DATA_FILE = 'app/services/Given_areas.json'.freeze

  def as_hash
    RGeo::GeoJSON.encode(features)
  end

  def as_geometry
    features.map { |feature| feature.geometry }
  end

  private

  def features
    file_location = Rails.root.join(DATA_FILE)

    @features ||= File.open(file_location) do |file|
      RGeo::GeoJSON.decode(file.read)
    end
  end
end