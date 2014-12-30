class StudyImport::Definitions::Question
  attr_accessor(:label)
  attr_accessor(:block_label)
  attr_accessor(:answer_type_label)
  attr_accessor(:text)

  def answer_type_id
    AnswerType.find_by_label(@answer_type_label).id
  end

  def block_id
    Block.find_by_label(self.block_label).id
  end

  def to_dictionary
    {
      answer_type_id: self.answer_type_id,
      label: @label,
      block_id: self.block_id,
      text: @text
    }
  end

  def create(client)
    url = Rails.application.routes.url_helpers.questions_path
    client.post url, question: to_dictionary
  end

  def read(config_node)
    @label = config_node["label"]
    @text = config_node["text"]
    @answer_type_label = config_node["answer_type_label"]
  end
end
