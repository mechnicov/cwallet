module Wallet
  class GetUtxos
    class << self
      def call(key)
        new(key).call
      end
    end

    def call
      get_utxos
    end

    private

    attr_reader :address

    def initialize(address)
      @address = address
    end

    def get_utxos
      utxos_url = "#{BLOCK_STREAM_API_BASE_URL}/address/#{address}/utxo"
      response = HTTParty.get(utxos_url)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
