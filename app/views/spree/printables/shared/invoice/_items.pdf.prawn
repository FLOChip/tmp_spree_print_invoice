header = [
  pdf.make_cell(content: Spree.t(:sku), :background_color => "eeeeee", :border_colors => 'eeeeee'),
  pdf.make_cell(content: Spree.t(:item_description), :background_color => "eeeeee", :border_colors => 'eeeeee'),
  pdf.make_cell(content: "SKU", :background_color => "eeeeee", :border_colors => 'eeeeee'),
  pdf.make_cell(content: Spree.t(:price), :background_color => "eeeeee", :border_colors => 'eeeeee'),
  pdf.make_cell(content: Spree.t(:qty), :background_color => "eeeeee", :border_colors => 'eeeeee'),
  pdf.make_cell(content: Spree.t(:total), :background_color => "eeeeee", :border_colors => 'eeeeee')
]
data = [header]

invoice.items.each do |item|
  row = [
    pdf.make_cell(content: item.sku, :border_colors => 'eeeeee'),
    pdf.make_cell(content: item.name, :border_colors => 'eeeeee'),
    pdf.make_cell(content: item.sku, :border_colors => 'eeeeee'),
    pdf.make_cell(content: item.display_price.to_s, :border_colors => 'eeeeee'),
    pdf.make_cell(content: item.quantity.to_s, :border_colors => 'eeeeee'),
    pdf.make_cell(content: item.display_total.to_s, :border_colors => 'eeeeee')
  ]
  data += [row]
end

column_widths = [0.13, 0.37, 0.185, 0.12, 0.075, 0.12].map { |w| w * pdf.bounds.width }

pdf.table(data, header: true, position: :center, column_widths: column_widths) do
  row(0).style align: :center, font_style: :bold
  column(0..2).style align: :left
  column(3..6).style align: :right
end
