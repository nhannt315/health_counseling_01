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

I18n.locale = 'en'

major_list.each do |ele|
  Major.create! name:ele
end

User.create!(name: "Admin",
  phone_number: "01639639540",
  admin: true,
  avatar: "avatar.jpg",
  prof_place: "Viet Nam",
  prof_spec: "Rang Ham Mat",
  info_confirmed: "000000",
  bio: "000000000",
  license: "fadsfa",
  identity_card: "fdsafda",
  prof_position: "Vien truong",
  reset_sent_at: Time.zone.now,
  email: "administrator@mail.com",
  password: "foobar",
  password_confirmation: "foobar",
  activated: true,
  activated_at: Time.zone.now)

bio = "Bác sĩ Nguyễn Thị Hoàn đã có hơn 35 năm kinh nghiệm và là bác sĩ đầu ngành chuyên khoa nội tiết nhi tại Việt Nam, tư vấn các bệnh lý bẩm sinh di truyền và chẩn đoán trước sinh. Bác sĩ Hoàn cũng là một trong những người đầu tiên của Việt Nam làm về chương trình sàng lọc sơ sinh bệnh suy giáp bẩm sinh và thiếu G6PD và đã được Tổng cục Dân số - Bộ Y tế đưa vào chương trình trọng điểm quốc gia và đang triển khai trên 51/63 tỉnh thành trong toàn quốc. Bên cạnh đó, bác sĩ Hoàn cũng là một trong những người đầu tiên làm về sàng lọc nguy cơ cao bệnh rối loạn chuyển hóa bẩm sinh ở Việt nam - Đề án hợp tác giữa Học viện Shimanne- Nhật bản với Bệnh viện Nhi trung ương, và tiếp tục hợp tác đến năm 2020.

Bác sĩ Nguyễn Thị Hoàn đã có trên 130 công trình nghiên cứu được đăng trên: Tạp chí nhi khoa Việt nam; Tạp chí Y học, các tạp chí nội tiết, Quân y ..Trong đó có 13 báo cáo đăng toàn văn trên tạp chí nước ngoài như “Gene”; ”Human Mutation”; ”Diabetes care”; ”Molecular genetic and metabolism”; ”Journal of Inherited metabolic disease”. Ngoài ra, bác sĩ Hoàn cũng đã có báo cáo khoa học trình bày tại nhiều Hội nghị quốc tế được tổ chức tại Nhật bản,Trung quốc, Singapore, Indonesia, Thai lan, Philippine, Hàn quốc, Mông Cổ, Lào."


doctor = Doctor.create!(
          name: "Nguyễn Thị Hoàn",
          email: "hoannt@gmail.com",
          phone_number: "0123213213",
          type: "Doctor",
          prof_place: "Phòng khám Nhi - Bác sĩ Nguyễn Thị Hoàn",
          bio: bio,
          recommend: true,
          address: "Ngõ 165 - Xuân Thủy - Dịch Vọng Hậu - Cầu Giấy - Hà Nội",
          prof_position: "Nguyên trưởng khoa Nội Tiết - Chuyển Hóa Di Truyền, Bệnh viện Nhi Trung ương",
          activated: true,
          request_doctor: true,
          doctor_activated: true,
          password: "foobar",
          password_confirmation: "foobar"
)
majors = Major.all.distinct 5
doctor.majors << majors


