class ChangeTotalPointsInReportCard < ActiveRecord::Migration[7.0]
  def change
    remove_column :report_cards, :total_points
    add_column :report_cards, :score, :decimal
  end
end
