RSpec.describe Api::V1::PerformanceDataController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'POST /api/v1/performance_data' do
    it 'creates a data entry' do
      post '/api/v1/performance_data', params: {
        performance_data: { data: { message: 'Average' } }
      }, headers: headers

      entry = PerformanceData.last
      expect(entry.data).to eq 'message' => 'Average'
    end
  end

  describe 'GET /api/v1/performance_data' do
    before do
      5.times { user.performance_data.create(data: { message: 'Average' }) }
    end
  
    it 'returns a collection of performance data' do
      get '/api/v1/performance_data', headers: headers
      expect(response_json['entries'].count).to eq 5
    end

    it 'retrieves a previously created data entry' do
      get '/api/v1/performance_data', headers: headers
      expect(response_json['entries'][0]['data']).to eq 'message' => 'Average'
      expect(response.status).to eq 200
    end
  end

  describe 'GET /api/v1/performance_data' do
    it 'counts 0 if no data to retrieve' do
      get '/api/v1/performance_data', headers: headers
      expect(response_json['entries'].count).to eq 0
      expect(response.status).to eq 200
    end
  end
end