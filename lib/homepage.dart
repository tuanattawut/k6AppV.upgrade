import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final auth = FirebaseAuth.instance;
  final users = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("K6 E-App", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  auth.signOut();
                  Navigator.pop(context);
                })
          ],
        ),
        body: StreamBuilder(
          stream: users.collection('Products').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Scaffold(
              body: snapshot.hasData
                  ? buildUsersList(snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          },
        ));
  }
}

ListView buildUsersList(QuerySnapshot data) {
  return ListView.builder(
    itemCount: data.size,
    itemBuilder: (BuildContext context, int index) {
      var model = data.docs.elementAt(index);
      return ListTile(
        leading: Text('ชื่อสินค้า'),
        title: Text(model['nameproduct']),
        trailing: Text("${model['Price']}"),
        onTap: () {},
      );
    },
  );
}
