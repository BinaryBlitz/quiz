class AddQuestionIdToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :question, index: true
  end
end
