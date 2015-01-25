class StudyImport::Definitions::AnswerType
  attr_accessor(:study_label)
  attr_accessor(:label)
  attr_accessor(:description)
  attr_accessor(:allow_multiple)
  attr_accessor(:regular_expression)
  attr_accessor(:choices)

  def initialize
    @choices = []
  end

  def study_id
    Study.find_by_label(@study_label).id
  end

  def to_dictionary
    dictionary = {
      label: @label,
      description: @description,
      study_id: self.study_id
    }
    if !@choices.empty?
      dictionary[:choices_attributes] = {}
      dictionary[:allow_multiple] = @allow_multiple
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
    result = client.post url, answer_type: to_dictionary
    if result.code != 200
      puts "ERROR: unable to create answer type %s: %s" % [ @label, result.body ]
    end
  end

  def read(config_node)
    @label = config_node["label"]
    @description = config_node["description"]
    @allow_multiple = false
    if config_node.has_key?("allow_multiple")
      @allow_multiple = config_node["allow_multiple"]
    end
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
