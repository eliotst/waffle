class StudyImport::Definitions::ScheduleTemplate
  attr_accessor(:entries)
  attr_accessor(:study_label)

  def initialize
    @entries = []
  end

  def to_dictionary
    dictionary = {
      study_id: study_id
    }

    index = 0
    entries_dictionary = {}
    @entries.each do |entry|
      entries_dictionary[index] = entry.to_dictionary
      index += 1
    end
    dictionary[:schedule_template_entries_attributes] = entries_dictionary
    dictionary
  end

  def study_id
    Study.find_by_label(@study_label).id
  end

  def create(client)
    url = Rails.application.routes.url_helpers.schedule_templates_path
    client.post url, schedule_template: to_dictionary
  end

  def read(config_node)
    entries_nodes = config_node["entries"]
    entries_nodes.each do |entry_node|
      entry = StudyImport::Definitions::ScheduleTemplateEntry.new
      entry.read(entry_node)
      @entries.append(entry)
    end
  end
end
