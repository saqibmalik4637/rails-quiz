json.report_card do
  json.partial! 'api/v1/report_cards/report_card', report_card: @report_card
end
