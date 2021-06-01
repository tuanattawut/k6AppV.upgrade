import 'package:flutter/material.dart';
import 'package:k6_app/models/chat_models.dart';
import 'package:k6_app/utility/normal_dialog.dart';

class ShowChatmana extends StatefulWidget {
  ShowChatmana({Key key}) : super(key: key);

  @override
  _ShowChatmanaState createState() => _ShowChatmanaState();
}

class _ShowChatmanaState extends State<ShowChatmana> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: ChatModel.dummyData.length,
        itemBuilder: (context, index) {
          ChatModel _model = ChatModel.dummyData[index];
          return Column(
            children: <Widget>[
              Divider(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  normalDialog(context, 'คุณคลิก');
                },
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(_model.manatitle),
                      SizedBox(
                        width: 20,
                      ),
                      Text(_model.message),
                    ],
                  ),
                  trailing: Text(
                    _model.datetime,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
