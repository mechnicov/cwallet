module Wallet
  class SendMoney
    class << self
      def call(args)
        new(args).call
      end
    end

    def call
      get_utxos
      create_tx
      send_money
    end

    private

    include Bitcoin::Builder
    include Wallet

    attr_reader :key, :address, :to, :sum, :balance, :total, :utxos, :tx

    def initialize(args)
      @sum = args[:sum]
      raise ArgumentError.new('Sum must be positive') unless sum.positive?

      @key = Bitcoin::Key.new(args[:key])

      @address = args[:from]
      @to = args[:to]

      @balance = GetBalance.(address)[:total]
      @total = sum + FEE
      raise BalanceTooLowError if total > balance
    end

    def get_utxos
      @utxos ||=
        GetUtxos.(address).map do |utxo|
          url = "#{BLOCK_STREAM_API_BASE_URL}/tx/#{utxo[:txid]}/raw"
          response = HTTParty.get(url)

          {
            tx: Bitcoin::P::Tx.new(response.body),
            index: utxo[:vout],
            amount: utxo[:value],
          }
        end
    end

    def create_tx
      @tx ||=
        build_tx do |t|
          utxos.each do |input|
            t.input do |i|
              i.prev_out input[:tx]
              i.prev_out_index input[:index]
              i.signature_key key
            end
          end

          t.output do |o|
            o.value btc_to_satoshis(sum)
            o.script { |s| s.recipient to }
          end

          change = balance - total

          if change > 0
            t.output do |o|
              o.value btc_to_satoshis(change)
              o.script { |s| s.recipient address }
            end
          end
        end
    end

    def send_money
      hex = tx.to_payload.unpack('H*').first
      url = "#{BLOCK_STREAM_API_BASE_URL}/tx"

      response =
        HTTParty.post(
          url,
          body: hex,
          headers: { 'Content-Type' => 'application/json' },
        )

      response.body
    end
  end
end
