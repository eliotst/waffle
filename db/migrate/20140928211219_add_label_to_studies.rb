class AddLabelToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :label, :string
  end
end
