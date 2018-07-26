major_list = ["Dược","Khám bệnh" ,"Y học cổ truyền","Sản phụ khoa","Răng - Hàm - Mặt",
"Nhi","Thẩm mỹ","Hồi sức - Cấp cứu","Chẩn đoán hình ảnh","Nội tiết","Nhãn khoa",
"Tai - Mũi - Họng","Đa khoa","Tim mạch","Chấn thương chỉnh hình - Cột sống",
"Xét nghiệm","Tâm thần","Gây mê hồi sức","Da liễu","Dinh dưỡng",
"Vật lý trị liệu - Phục hồi chức năng","Ung bướu","Thận - Tiết niệu",
"Truyền nhiễm","Hô hấp","Giải phẫu bệnh","Thần kinh",
"Huyết học - Truyền máu","Tiêu hóa - Gan mật","Cơ Xương Khớp","Nội soi",
"Kiểm soát nhiễm khuẩn","Thăm dò chức năng","Nam khoa",
"Lão khoa","Thú y","Hiếm muộn - Vô sinh","Dị ứng - Miễn dịch",
"Di truyền & Sinh học phân tử","Tâm lý"]

major_list.each do |ele|
  Major.create name:ele
end

User.create!(name: "Admin",
  phone_number: "01639639540",
  admin: true,
  type: "Doctor",
  prof_place: "Viet Nam",
  prof_spec: "Rang Ham Mat",
  info_confirmed: "000000",
  bio: "000000000",
  license: "fadsfa",
  identity_card: "fdsafda",
  prof_position: "Vien truong",
  reset_sent_at: Time.zone.now,
  email: "admin@delight.com",
  password: "159753",
  password_confirmation: "159753",
  activated_at: Time.zone.now)
