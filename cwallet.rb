require 'optparse'

ARGV << '--help' if ARGV.empty?

OptionParser.new do |opt|
  opt.banner = 'Usage: cwallet.rb [options]'

  opt.on('--help', 'Prints this help') { return puts opt }
  opt.on('--key', 'generate and save to .key file') { return puts 'Key saved' }
  opt.on('--balance','show balance') { return puts 'Balance is...' }
  opt.on('--sum=SUM', 'send SUM', Float)
  opt.on('--address=ADDRESS', 'send to ADDRESS')
end.parse!(into: options = {})
