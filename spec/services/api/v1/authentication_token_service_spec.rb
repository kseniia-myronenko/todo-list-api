RSpec.describe Api::V1::AuthenticationTokenService, type: :service do
  describe '.call' do
    let(:token) { described_class.new(create(:user)).call }
    let(:decoded_token) do
      JWT.decode(token,
                 Rails.application.credentials.jwt_secret,
                 true,
                 algorithm: described_class::ALGORITHM_TYPE)
    end

    it 'returns an authentication token' do
      expect(decoded_token).to eq(
        [{ 'test' => 'blah' }, { 'alg' => 'HS256' }]
      )
    end
  end
end
