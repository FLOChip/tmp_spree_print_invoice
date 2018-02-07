pdf.repeat(:all) do
  pdf.grid([5,10], [0,0]).bounding_box do
    empty_cell = pdf.make_cell(content: "", :border_colors => "ffffff")
    billing_content = pdf.make_cell(content: "123", :border_colors => ["ffffff", "ffffff", "000000", "eeeeee"], align: :center)
    shipping_content = pdf.make_cell(content: "123", :border_colors => ["ffffff", "eeeeee", "eeeeee", "eeeeee"])

    data = [[empty_cell, billing_content, empty_cell]]
    pdf.table(data, position: :center, column_widths: [pdf.bounds.width / 5, pdf.bounds.width / 5 * 3, pdf.bounds.width / 5])
  end
end
