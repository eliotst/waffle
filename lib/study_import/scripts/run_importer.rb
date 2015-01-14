require Rails.root.join("lib/study_import/client")
require Rails.root.join("lib/study_import/importer")

if __FILE__ == $PROGRAM_NAME
  data_filename = ARGV[0] or Rails.root.join("config", "study_data", "movie_example.yaml")
  
  if File.file?(data_filename) 
    yaml_data = File.read(data_filename)
    client = StudyImport::HTTPClient.new("http://localhost:3000")
    client.post "/sessions", email: "admin@waffle.com", password: "12345"
    StudyImport::Importer.new(yaml_data, client)
  else
    puts "File does not exist: " + data_filename
  end
end
