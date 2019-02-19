import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AccountState();
  }
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: new Center(child: Text("Account")),
    );
  }
}
