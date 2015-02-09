require "optparse"

require Rails.root.join("lib/study_import/client")
require Rails.root.join("lib/study_import/importer")

if __FILE__ == $PROGRAM_NAME
  options = {
    host: "localhost:3000",
    username: "admin@waffle.com",
    password: "12345",
    config: ""
  }
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: run_importer.rb [options] <study_config>"

    opts.on("-H s", "--host=s", "Host/port of the Waffle server") do |host|
      options[:host] = host
    end
    opts.on("-u s", "--username=s", "Username of the user to use") do |username|
      options[:username] = username
    end
    opts.on("-p s", "--password=s", "Password of the user to use") do |password|
      options[:password] = password
    end
    opts.on("-c s", "--config=s", "Study config file") do |file|
      options[:config] = file
    end
  end
  option_parser.parse!(ARGV)

  if File.file?(options[:config])
    yaml_data = File.read(options[:config])
    client = StudyImport::HTTPClient.new("http://" + options[:host] + "/")
    client.post "/sessions", email: options[:username], password: options[:password]
    StudyImport::Importer.new(yaml_data, client)
  else
    puts "File does not exist: " + options[:config]
  end
end
