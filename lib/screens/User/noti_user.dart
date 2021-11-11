import 'package:flutter/material.dart';
import 'package:k6_app/models/user_models.dart';
import 'package:k6_app/screens/User/promotionfollow_user.dart';
import 'package:k6_app/screens/User/promotionseller_user.dart';

class NotiUser extends StatefulWidget {
  NotiUser({required this.userModel});
  final UserModel userModel;
  @override
  _NotiUserState createState() => _NotiUserState();
}

class _NotiUserState extends State<NotiUser> {
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ประกาศแจ้งเตือน'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'แจ้งเตือนจากร้านค้า'),
                Tab(text: 'แจ้งเตือนจากติดตาม'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PromotionUser(),
              PromotionFollow(userModel: userModel!),
            ],
          ),
        ));
  }
}
