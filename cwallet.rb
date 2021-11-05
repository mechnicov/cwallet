require 'optparse'

require_relative 'lib/wallet'

ARGV << '--help' if ARGV.empty?

OptionParser.new do |opt|
  opt.banner = 'Usage: cwallet.rb [options]'

  opt.on('--help', 'Prints this help') { return puts opt }

  opt.on('--generate', 'generate wallet and save to key file') do
    wallet_data = Wallet::GenerateWallet.()

    wallet_dir = File.join(__dir__, 'wallets', wallet_data[:address])
    Dir.mkdir(wallet_dir)

    key_path = File.join(wallet_dir, '.key')
    File.open(key_path, 'w') { |f| f.puts wallet_data[:key] }

    puts "Key was saved to #{key_path}"
    return
  end

  opt.on('--balance=ADDRESS', 'show wallet balance', String) do |address|
    balance = Wallet::GetBalance.(address)
    puts <<~BALANCE
      Wallet '#{address}' balance:
      Total: #{balance[:total]}฿T
      Confirmed: #{balance[:confirmed]}฿T
      Unconfirmed: #{balance[:unconfirmed]}฿T
    BALANCE
    return
  end

  opt.on('--sum=SUM', 'send SUM', Float)
  opt.on('--from=ADDRESS', 'from ADDRESS', String)
  opt.on('--to=ADDRESS', 'send to ADDRESS', String)
end.parse!(into: options = {})

unless options.values_at(:from, :to).all?
  puts 'You have to specify wallet and receiver address'
  return
end

key = File.read(File.join(__dir__, 'wallets', options[:from], '.key')).chomp
from = options[:from]
to = options[:to]
sum = options[:sum]

tx_id = Wallet::SendMoney.(sum: sum, key: key, from: from, to: to)

puts <<~TRANSACTION
  #{sum}฿T was sent from #{from} to #{to}
  TXID is #{tx_id}
TRANSACTION
