module Wallet
  class GetBalance
    class << self
      def call(key)
        new(key).call
      end
    end

    def call
      get_balance
    end

    private

    include Wallet

    attr_reader :address

    def initialize(address)
      @address = address
    end

    def get_balance
      utxos = GetUtxos.(address)

      total = utxos.sum { |utxo| utxo[:value] }
      confirmed = utxos.filter_map { |utxo| utxo[:value] if utxo.dig(:status, :confirmed) }.sum
      unconfirmed = total - confirmed

      {
        total: satoshis_to_btc(total),
        confirmed: satoshis_to_btc(confirmed),
        unconfirmed: satoshis_to_btc(unconfirmed),
      }
    end
  end
end
