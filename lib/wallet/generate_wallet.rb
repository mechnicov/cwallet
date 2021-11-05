module Wallet
  class GenerateWallet
    class << self
      def call
        new.call
      end
    end

    def call
      generate_wallet
    end

    private

    def generate_wallet
      key = Bitcoin::Key.generate

      {
        key: key.priv,
        address: key.addr,
      }
    end
  end
end
