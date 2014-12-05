class StudyImport::Definitions::Choice
  attr_accessor(:value)
  attr_accessor(:text)
  attr_accessor(:order)

  def to_dictionary
    {
      value: @value,
      text: @text,
      order: @order
    }
  end

  def read(config_node)
    @value = config_node["value"]
    @text = config_node["text"]
    @order = config_node["order"].to_int
  end
end
