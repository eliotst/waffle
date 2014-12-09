class StudyImport::Definitions::Study
  attr_accessor(:title)
  attr_accessor(:label)

  def to_dictionary
    {
      title: @title,
      label: @label
    }
  end

  def create(client)
    url = Rails.application.routes.url_helpers.studies_path
    client.post url, study: to_dictionary
  end

  def read(config_node)
    @title = config_node["title"]
    @label = config_node["label"]
  end
end
