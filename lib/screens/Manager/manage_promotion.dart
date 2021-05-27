import 'package:flutter/material.dart';
import 'package:k6_app/utility/my_style.dart';

class ManagePromotion extends StatefulWidget {
  @override
  _ManagePromotionState createState() => _ManagePromotionState();
}

class _ManagePromotionState extends State<ManagePromotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดการประกาศโปรโมชั่น'),
      ),
      backgroundColor: Colors.white70,
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'ประกาศ ${data[index]}',
                                style: MyStyle().mainTitle,
                              ),
                              Text('${data2[index]}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final List<String> data = <String>['1', '2', '3', '4'];
  final List<String> data2 = <String>[
    'ก เอ๋ย กอไก่ ข ไข่ ในเล้าdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
    'ฃ.ขวดของเรา ค.ควายเข้านา',
    'ค.คนขึงขัง ฆ.ระฆังข้างขวา',
    'ง.งูใจกล้า จ.จานใช้ดี'
  ];
}