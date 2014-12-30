class StudyImport::Definitions::ScheduleTemplateEntry
  attr_accessor(:time_offset_hours)
  attr_accessor(:questionnaire_label)

  def to_dictionary
    {
      time_offset_hours: @time_offset_hours,
      questionnaire_id: self.questionnaire_id
    }
  end

  def questionnaire_id
    Questionnaire.find_by_label(@questionnaire_label).id
  end

  def read(config_node)
    @time_offset_hours = config_node["time_offset_hours"].to_int
    @questionnaire_label = config_node["questionnaire_label"]
  end
end
