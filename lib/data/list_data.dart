
class ListDataInfor {
  final String img;
  final String description;

  ListDataInfor({this.img, this.description});
}

List<ListDataInfor> symptoms = [
  ListDataInfor(
    img: "assets/symptoms/headache.png",
    description: "Đau đầu",
  ),
  ListDataInfor(
    img: "assets/symptoms/high_fever.png",
    description: "Sốt cao",
  ),
  ListDataInfor(
    img: "assets/symptoms/cough.png",
    description: "Ho",
  ),
  ListDataInfor(
    img: "assets/symptoms/sore_troath.png",
    description: "Đau họng",
  ),
];

List<ListDataInfor> prevention = [
  ListDataInfor(
    img: "assets/prevention/mask.png",
    description: "Đeo khẩu trang ở nơi đông người",
  ),
  ListDataInfor(
    img: "assets/prevention/home.png",
    description: "Làm việc tại nhà (nếu có thể)",
  ),
  ListDataInfor(
    img: "assets/prevention/wash_hand.png",
    description: "Rửa tay bằng xà phòng",
  ),
  ListDataInfor(
    img: "assets/prevention/contact_hand.png",
    description: "Hạn chế tiếp xúc trực tiếp",
  ),
  ListDataInfor(
    img: "assets/prevention/protect6.png",
    description: "Thường xuyên vệ sinh nhà cửa",
  ),
  ListDataInfor(
    img: "assets/prevention/no_hand.png",
    description: "Không đưa tay lên mặt",
  ),
];

List<ListDataInfor> contagion = [
  ListDataInfor(
    img: "assets/contagion/air.png",
    description: "Giọt bắn khi tiếp xúc gần",
  ),
  ListDataInfor(
    img: "assets/contagion/personal_contact.png",
    description: "Tiếp xúc trực tiếp với người bệnh",
  ),
  ListDataInfor(
    img: "assets/contagion/contaminated.png",
    description: "Tiếp xúc với bề mặt bị nhiễm bẩn",
  ),
  ListDataInfor(
    img: "assets/contagion/animal_contact.png",
    description: "Tiếp xúc với động vật hoang dã",
  ),
];
