import 'package:flutter/material.dart';
import 'package:k6_app/models/chat_models.dart';
import 'package:k6_app/utility/my_style.dart';

class ShowChatmana extends StatefulWidget {
  ShowChatmana({Key key}) : super(key: key);

  @override
  _ShowChatmanaState createState() => _ShowChatmanaState();
}

class _ShowChatmanaState extends State<ShowChatmana> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MyStyle().mySizebox(),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'หัวข้อ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'รายละเอียด',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'วันที่และเวลา',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ChatModel.dummyData.length,
            itemBuilder: (context, index) {
              ChatModel _model = ChatModel.dummyData[index];
              return Column(
                children: <Widget>[
                  Divider(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      final snackBar = SnackBar(
                        content: Text('คุณคลิกหัวข้อ ${_model.manatitle}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              _model.manatitle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text(_model.message)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text(_model.datetime)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  var id = [
    "title 1",
    "title 2",
    "title 3",
    "title 4",
    "title 5",
  ];
}
