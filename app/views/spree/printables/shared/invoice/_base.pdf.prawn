font_style = {
  face: Spree::PrintInvoice::Config[:font_face],
  size: Spree::PrintInvoice::Config[:font_size]
}

prawn_document(force_download: true, page_layout: :portrait) do |pdf|
  pdf.define_grid(columns: 5, rows: 10, gutter: 10)
  pdf.font font_style[:face], size: font_style[:size]

  pdf.repeat(:all) do
    render 'spree/printables/shared/header', pdf: pdf, printable: doc
  end

  # CONTENT
  pdf.grid([0.7,0], [6,4]).bounding_box do

    # address block on first page only
    if pdf.page_number == 1
      order_cell = [pdf.make_cell(content: "Order Number", font_style: :bold, borders: [:top], padding_top: 20), pdf.make_cell(content: ": " + doc.number, borders: [:top], padding_top: 20)]
      date_cell = [pdf.make_cell(content: "Order Date", font_style: :bold, borders: []), pdf.make_cell(content: ": " + I18n.l(doc.date), borders: [])]
      payment_cell = [pdf.make_cell(content: "Payment Method", font_style: :bold, borders: []), pdf.make_cell(content: ": eGHL", borders: [])]
      data = [order_cell, date_cell, payment_cell]

      pdf.table(data, position: :center, column_widths: [pdf.bounds.width / 6, pdf.bounds.width / 6 * 5])
      pdf.move_down 15
      render 'spree/printables/shared/address_block', pdf: pdf, printable: doc
    end

    pdf.move_down 20

    render 'spree/printables/shared/invoice/items', pdf: pdf, invoice: doc

    pdf.move_down 10

    render 'spree/printables/shared/totals', pdf: pdf, invoice: doc

    pdf.move_down 30

    pdf.text Spree::PrintInvoice::Config[:return_message], align: :right, size: font_style[:size]
  end

  pdf.grid([10,0], [9,4]).bounding_box do
    order_cell = [pdf.make_cell(content: "", font_style: :bold, borders: [:top], padding_top: 20), pdf.make_cell(content: "", borders: [:top], padding_top: 20)]
    data = [order_cell]

    pdf.table(data, position: :center, column_widths: [pdf.bounds.width / 6, pdf.bounds.width / 6 * 5])
    pdf.text "LIKE US on Facebook.com/theminipuer", align: :center
    pdf.text "FOLLOW US on Instagram.com/theminipuer", align: :center
    pdf.text "If you have any question, feel free to contact us at admin@theminipuer.com.", align: :center
    pdf.text "www.theminipuer.com", style: :bold, align: :center
  end

  # Page Number
  if Spree::PrintInvoice::Config[:use_page_numbers]
    render 'spree/printables/shared/page_number', pdf: pdf
  end
end
