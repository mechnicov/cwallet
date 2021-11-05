require 'wallet'

describe Wallet::GetUtxos do
  before do
    VCR.use_cassette('get_utxos') do
      @utxos = described_class.call('msJbhJB1x5TSudZtRAXBD5mf9rPX3MT9TA')
    end
  end

  describe '::call' do
    it 'returns utxos array' do
      expect(@utxos).to be_an Array
    end

    it 'consists of hashes with required keys' do
      expect(@utxos).to all be_a(Hash).and include(:txid, :vout, :status, :value)
    end

    it 'contains status of every output' do
      expect(@utxos.map { |utxo| utxo[:status] }).to all be_a(Hash).and include(:confirmed, :block_height, :block_hash, :block_time)
    end
  end
end
