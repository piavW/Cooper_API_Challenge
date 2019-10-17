RSpec.describe 'Sessions', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'POST /api/v1/auth/sign_in' do
    it 'valid credentials returns user' do
      post '/api/v1/auth/sign_in', params: { email: user.email,
                                             password: user.password
                                          }, headers: headers

      expected_response = {
        'data' => {
          'id' => user.id, 'uid' => user.email, 'email' => user.email,
          'provider' => 'email', 'name' => nil, 'nickname' => nil,
          'image' => nil, 'allow_password_change' => false
        }    
      }

      expect(response_json).to eq expected_response
    end

    it 'invalid password returns error message' do
      post '/api/v1/auth/sign_in', params: { email: user.email,
                                             password: 'wrong_password'
                                          }, headers: headers

      expect(response_json['errors'])
        .to eq ['Invalid login credentials. Please try again.']

      expect(response.status).to eq 401
    end

    it 'invalid email returns error message' do
      post '/api/v1/auth/sign_in', params: { email: 'wrong@email.com',
                                             password: user.password
                                          }, headers: headers

      expect(response_json['errors'])
        .to eq ['Invalid login credentials. Please try again.']

      expect(response.status).to eq 401
    end
  end
end