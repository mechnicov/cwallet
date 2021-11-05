require 'wallet'

describe Wallet::GenerateWallet do
  let(:wallet_data) { described_class.call }

  describe '::call' do
    it 'returns hash with generated wallet data' do
      expect(wallet_data).to include(:key, :address)
    end

    it 'returns compatible key and address' do
      expect(Bitcoin::Key.new(wallet_data[:key]).addr).to eq(wallet_data[:address])
    end
  end
end
