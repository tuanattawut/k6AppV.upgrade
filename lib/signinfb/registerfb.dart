import 'package:flutter/material.dart';

class RegisterfbPage extends StatefulWidget {
  @override
  _RegisterfbPageState createState() => _RegisterfbPageState();
}

class _RegisterfbPageState extends State<RegisterfbPage> {
  final _formstate = GlobalKey<FormState>();
  String typeUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register with Facebook",
              style: TextStyle(color: Colors.white)),
        ),
        body: Form(
          key: _formstate,
          child: ListView(
            children: <Widget>[
              buildNameField(),
              buildEmailField(),
              buildPasswordField(),
              buildPhoneField(),
              buildTitle(),
              buildTyperUser(),
              buildTyperMerchant(),
              buildRegisterButton(),
            ],
          ),
        ));
  }

  RadioListTile<String> buildTyperMerchant() {
    return RadioListTile(
      value: 'merchant',
      groupValue: typeUser,
      onChanged: (value) {
        setState(() {
          typeUser = value;
        });
      },
      title: Text('Merchant'),
    );
  }

  RadioListTile<String> buildTyperUser() {
    return RadioListTile(
      value: 'user',
      groupValue: typeUser,
      onChanged: (value) {
        setState(() {
          typeUser = value;
        });
      },
      title: Text('User'),
    );
  }

  Container buildTitle() {
    return Container(
        margin: EdgeInsets.only(top: 20), child: Text('Type User : '));
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: Text('Register'),
      onPressed: () async {},
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'aa@aa.com',
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Full Name',
        icon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      validator: (value) {
        if (value.length < 10)
          return 'Please Enter more than 10 Character';
        else
          return null;
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        icon: Icon(Icons.phone_android),
      ),
    );
  }
}
