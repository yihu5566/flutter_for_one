import 'package:flutter/material.dart';
import 'package:flutter_for_one/ui/account/account.dart';
import 'package:flutter_for_one/ui/all/all.dart';
import 'package:flutter_for_one/ui/index/index.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(primaryColor: Colors.white),
      home: BottomNavigationWidget(),
    );
  }
}

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavigationWidgetState();
  }
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  //所有的界面啊
  List<Widget> pages = List<Widget>();
  var appBarTitles = ['Home', 'All', 'Me'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages.add(Index());
    pages.add(All());
    pages.add(Account());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
          BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
          BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }

  Text getTabTitle(int curIndex) {
    if (curIndex == _currentIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }

  Icon getTabIcon(int curIndex) {
    Icon tab;
    switch (curIndex) {
      case 0:
        if (curIndex == _currentIndex) {
          tab = new Icon(Icons.home, color: const Color(0xff1296db));
        } else {
          tab = new Icon(Icons.home, color: const Color(0xff515151));
        }
        break;
      case 1:
        if (curIndex == _currentIndex) {
          tab = new Icon(Icons.apps, color: const Color(0xff1296db));
        } else {
          tab = new Icon(Icons.apps, color: const Color(0xff515151));
        }
        break;
      case 2:
        if (curIndex == _currentIndex) {
          tab = new Icon(Icons.account_box, color: const Color(0xff1296db));
        } else {
          tab = new Icon(Icons.account_box, color: const Color(0xff515151));
        }
        break;
    }
    return tab;
  }
}
