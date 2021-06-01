class ChatModel {
  final String manatitle;
  final String datetime;
  final String message;

  ChatModel({this.manatitle, this.datetime, this.message});

  static final List<ChatModel> dummyData = [
    ChatModel(
      manatitle: "อะไรครับเนี่ยห",
      datetime: "2021-05-27  08:15",
      message: "อยู่ที่ไหน",
    ),
    ChatModel(
      manatitle: "ติดต่อหน่อยงับ",
      datetime: "2021-05-28  20:18",
      message: "คุณช่วยฉันได้ไหม",
    ),
    ChatModel(
      manatitle: "เฮลโล่ฮาวอายู",
      datetime: "2021-05-29  19:22",
      message: "ห้องน้ำไปทางไหน!",
    ),
    ChatModel(
      manatitle: "สวัสดีครับ",
      datetime: "2021-05-30  14:34",
      message: "ฉันลืมของช่วยหาหน่อย",
    ),
    ChatModel(
      manatitle: "สวัสดีครับ",
      datetime: "2021-05-31  11:05",
      message: "หาเจอยัง",
    ),
    ChatModel(
      manatitle: "สวัสดีครับ",
      datetime: "2021-06-01  09:46",
      message: "หาให้อีกทีเผื่อเจอนะ",
    ),
    ChatModel(
      manatitle: "สวัสดีครับ",
      datetime: "2021-06-02  08:15",
      message: "เจอแล้วครับ ไม่ได้เอาไป",
    ),
  ];
}
