
class StudyImport::Definitions::Questionnaire
  attr_accessor(:label)
  attr_accessor(:study_label)

  def study_id
    Study.find_by_label(self.study_label).id
  end

  def to_dictionary
    {
      study_id: self.study_id,
      label: @label
    }
  end

  def create(client)
    url = Rails.application.routes.url_helpers.questionnaires_path
    client.post url, questionnaire: to_dictionary
  end

  def read(config_node)
    @label = config_node["label"]
  end
end
