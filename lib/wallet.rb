require 'bitcoin'
require 'httparty'

Bitcoin.network = :testnet

Dir[File.join(__dir__, 'wallet', '**', '*.rb')].each { |f| require f }

module Wallet
  BLOCK_STREAM_API_BASE_URL ='https://blockstream.info/testnet/api'.freeze
  SATOSHIS_IN_BTC = 100_000_000

  def satoshis_to_btc(satoshis)
    satoshis.to_f / SATOSHIS_IN_BTC
  end
end
