class StudyImport::Definitions::Block
  attr_accessor(:label)
  attr_accessor(:questions)

  def initialize
    @questions = []
  end

  def to_dictionary
    {
      label: @label
    }
  end

  def create(client)
    url = Rails.application.routes.url_helpers.blocks_path
    result = client.post url, block: to_dictionary
    if result != 200
      puts "ERROR: unable to create block " + @label
    end
    @questions.each do |question|
      question.create(client)
    end
  end

  def read(config_node)
    @label = config_node["label"]
    @questions = []
    number = 1
    config_node["questions"].each do |question_node|
      question_definition = StudyImport::Definitions::Question.new
      question_definition.read(question_node)
      question_definition.block_label = @label
      question_definition.number = number
      @questions.append(question_definition)
      number += 1
    end
  end
end
