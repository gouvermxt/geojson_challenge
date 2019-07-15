require 'rgeo/geo_json'

# Checks if a point is inside any of the areas
class PointChecker
  def within_areas?(geojson_point)
    geo_point = RGeo::GeoJSON.decode(geojson_point)    
    areas = GeoAreas.new.as_geometry
    is_inside = areas.any? { |area| area.contains?(geo_point) }
    { is_inside: is_inside }
  # GeoJSON emmits NoMethodError when it can't parse the point
  rescue NoMethodError 
    { error: 'Invalid GeoJSON point' }
  end
end