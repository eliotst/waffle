class StudyImport::Definitions::AnswerType
  attr_accessor(:label)
  attr_accessor(:description)
  attr_accessor(:regular_expression)
  attr_accessor(:choices)

  def initialize
    @choices = []
  end

  def to_dictionary
    dictionary = {
      label: @label,
      description: @description
    }
    if !@choices.empty?
      dictionary[:choices_attributes] = {}
      index = 0
      @choices.each do |choice|
        dictionary[:choices_attributes][index] = choice.to_dictionary
        index = index + 1
      end
    else
      dictionary[:answer_validation_attributes] = {
        regular_expression: @regular_expression
      }
    end
    dictionary
  end

  def create(client)
    url = Rails.application.routes.url_helpers.answer_types_path
    client.post url, answer_type: to_dictionary
  end

  def read(config_node)
    @label = config_node["label"]
    @description = config_node["description"]
    if config_node.has_key?("choices")
      choices_node = config_node["choices"]
      choices_node.each do |choice_node|
        choice = StudyImport::Definitions::Choice.new
        choice.read(choice_node)
        @choices.append(choice)
      end
    else
      @regular_expression = config_node["regular_expression"]
    end
  end
end
