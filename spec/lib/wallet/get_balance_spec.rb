require 'wallet'

describe Wallet::GetBalance do
  before do
    VCR.use_cassette('get_utxos') do
      @balance = described_class.call('msJbhJB1x5TSudZtRAXBD5mf9rPX3MT9TA')
    end
  end

  describe '::call' do
    it 'returns balance by address including confirmed and unconfirmed parts' do
      expect(@balance).to be_a(Hash).and include(:total, :confirmed, :unconfirmed)
    end

    it 'returns balance as floats' do
      expect(@balance.values).to all be_a Float
    end

    it 'returns consistent amount data ' do
      expect(@balance[:confirmed] + @balance[:unconfirmed]).to eq @balance[:total]
    end
  end
end
