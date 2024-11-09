class AddRoomIdToReportCard < ActiveRecord::Migration[7.0]
  def change
    add_column :report_cards, :room_id, :bigint
  end
end
