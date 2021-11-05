require 'bitcoin'
require 'httparty'
require 'json'

Bitcoin.network = :testnet

Dir[File.join(__dir__, 'wallet', '**', '*.rb')].each { |f| require f }

module Wallet
  class Error < StandardError; end

  class BalanceTooLowError < Error
    def message
      'Balance is too low for this operation'
    end
  end

  BLOCK_STREAM_API_BASE_URL ='https://blockstream.info/testnet/api'.freeze
  SATOSHIS_IN_BTC = 100_000_000
  FEE = 0.0001

  def satoshis_to_btc(satoshis)
    satoshis.to_f / SATOSHIS_IN_BTC
  end

  def btc_to_satoshis(btc)
    btc * SATOSHIS_IN_BTC
  end
end
