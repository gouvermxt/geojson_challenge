# Reads the list of geographical areas in GeoJSON format
class GeoAreas
  DATA_FILE = 'Given_areas.json'.freeze

  def as_hash
    features.map { |feature| RGeo::GeoJSON.encode(feature) }
  end

  def as_geometry
    features.map { |feature| feature.geometry }
  end

  private

  def features
    @features ||= File.open(DATA_FILE) do |file|
      RGeo::GeoJSON.decode(file.read)
    end
  end
end