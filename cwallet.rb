require 'optparse'

Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |f| require f }

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

  opt.on('--balance','show balance') { return puts 'Balance is...' }
  opt.on('--sum=SUM', 'send SUM', Float)
  opt.on('--address=ADDRESS', 'send to ADDRESS')
end.parse!(into: options = {})
