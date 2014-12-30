Dir[Rails.root.join("app/models/*.rb")].each { |f| require f }

class StudyImport::Importer
  attr_accessor(:config)
  attr_accessor(:study_definition)
  attr_accessor(:answer_type_definitions)
  attr_accessor(:block_definitions)
  attr_accessor(:question_definitions)
  attr_accessor(:questionnaire_definitions)
  attr_accessor(:schedule_template_definition)

  def initialize(yaml, http_client)
    @yaml_data = yaml
    @client = http_client
    ingest_yaml
    create_data
  end

  private
  def ingest_yaml
    @config = YAML.load(@yaml_data)
    read_data
  end

  def read_data
    study_node = @config["study"]
    read_study_node study_node
    read_answer_types_node study_node["answer_types"]
    read_blocks_node study_node["blocks"]
    read_questionnaires_node study_node["questionnaires"]
    read_schedule_node study_node["schedule_template"]
  end

  def create_data
    @study_definition.create(@client)
    @answer_type_definitions.each do |definition|
      definition.create(@client)
    end
    @block_definitions.each do |definition|
      definition.create(@client)
    end
    @questionnaire_definitions.each do |definition|
      definition.create(@client)
    end
    @schedule_template_definition.create(@client)
  end

  def read_study_node(study_node)
    @study_definition = StudyImport::Definitions::Study.new
    @study_definition.read(study_node)
  end

  def read_answer_types_node(answer_types_node)
    @answer_type_definitions = []
    answer_types_node.each do |answer_type_node|
      definition = StudyImport::Definitions::AnswerType.new
      definition.read(answer_type_node)
      @answer_type_definitions.append(definition)
    end
  end

  def read_blocks_node(blocks_node)
    @block_definitions = []
    blocks_node.each do |block_node|
      block = StudyImport::Definitions::Block.new
      block.read(block_node)
      @block_definitions.append(block)
    end
  end

  def read_questionnaires_node(questionnaires_node)
    @questionnaire_definitions = []
    questionnaires_node.each do |questionnaire_node|
      questionnaire = StudyImport::Definitions::Questionnaire.new
      questionnaire.read(questionnaire_node)
      questionnaire.study_label = @study_definition.label
      @questionnaire_definitions.append(questionnaire)
    end
  end

  def read_schedule_node(schedule_node)
    @schedule_template_definition = StudyImport::Definitions::ScheduleTemplate.new
    @schedule_template_definition.read(schedule_node)
    @schedule_template_definition.study_label = @study_definition.label
  end
end
