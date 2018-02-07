im = Rails.application.assets.find_asset('doc/logo-tmp.png')
xjy = Rails.application.assets.find_asset('doc/logo-xjy.png')

if im && File.exist?(im.pathname)
  pdf.image im.filename, vposition: :top, height: 40, scale: Spree::PrintInvoice::Config[:logo_scale]
end

pdf.grid([0,0], [0,4]).bounding_box do
  pdf.text "Xin Ju Yuan Sdn Bhd (626373-M)", align: :center
  pdf.text "17-2 (1st Floor), Jalan SS23/15, Taman SEA", align: :center
  pdf.text "47400 Petaling Jaya, Selangor, Malaysia", align: :center
  pdf.text "Email: admin@theminipuer.com", align: :center
end

if xjy && File.exist?(xjy.pathname)
  pdf.image xjy.filename, vposition: :top, position: :right, height: 40, scale: Spree::PrintInvoice::Config[:logo_scale]
end
