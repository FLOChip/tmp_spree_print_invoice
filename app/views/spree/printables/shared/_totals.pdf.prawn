# TOTALS
totals = []

# Subtotal
totals << [pdf.make_cell(content: Spree.t(:subtotal)), pdf.make_cell(content: invoice.display_item_total.to_s, :border_colors => 'eeeeee')]

# Adjustments
invoice.adjustments.each do |adjustment|
  totals << [pdf.make_cell(content: adjustment.label), pdf.make_cell(content: adjustment.display_amount.to_s, :border_colors => 'eeeeee')]
end

# Shipments
invoice.shipments.each do |shipment|
  totals << [pdf.make_cell(content: shipment.shipping_method.name), pdf.make_cell(content: shipment.display_cost.to_s, :border_colors => 'eeeeee')]
end

# Totals
totals << [pdf.make_cell(content: Spree.t(:order_total)), pdf.make_cell(content: invoice.display_total.to_s, :border_colors => 'eeeeee')]

# Payments
# total_payments = 0.0
# invoice.payments.each do |payment|
#  totals << [
#    pdf.make_cell(
#      content: Spree.t(:payment_via,
#      gateway: (payment.source_type || Spree.t(:unprocessed, scope: :print_invoice)),
#      number: payment.number,
#      date: I18n.l(payment.updated_at.to_date, format: :long),
#      scope: :print_invoice)
#    ),
#    payment.display_amount.to_s
#  ]
  # total_payments += payment.amount
#end

totals_table_width = [0.875, 0.125].map { |w| w * pdf.bounds.width }
pdf.table(totals, column_widths: totals_table_width) do
  row(0..6).style align: :right
  column(0).style borders: [], font_style: :bold
end
