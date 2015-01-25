
class StudyImport::Definitions::Questionnaire
  attr_accessor(:blocks)
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
    result = client.post url, questionnaire: to_dictionary
    if result != 200
      puts "ERROR: unable to create questionnaire %s: %s" % [ @label, result.body ]
    end
    self.add_blocks(client)
  end

  def add_blocks(client)
    questionnaire = Questionnaire.find_by_label(@label)
    @blocks.each do |block_label|
      block = Block.find_by_label(block_label)
      url = Rails.application.routes.url_helpers.block_questionnaires_path
      client.post url,
        questionnaire_id: questionnaire.id,
        block_id: block.id
    end
  end

  def read(config_node)
    @label = config_node["label"]
    @blocks = config_node["blocks"]
  end
end
