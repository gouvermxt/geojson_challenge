# Provides helpers for request specs
module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def base_headers
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  def stub_given_areas
    FakeFS::FileSystem.clone(Rails.root)
    stub = Rails.root.join('spec/fixtures/files/Given_areas.json')
    destination = Rails.root.join('app/services/Given_areas.json')
    FileUtils.remove_entry_secure(destination)
    FileUtils.cp_r(stub, destination)
    stub.read
  end
end