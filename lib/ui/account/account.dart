import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_for_one/http/api.dart';
import 'package:flutter_for_one/http/http_util.dart';
import 'package:flutter_for_one/ui/account/account_edit_bean.dart';
import 'package:flutter_for_one/ui/account/account_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainAccount();
  }
}

class MainAccount extends State<Account> {
  var _mMainBean;
  var userInfo;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _mMainBean == null
        ? new Center(
            child: new CircularProgressIndicator(),
          )
        : new Scaffold(
            body: new MainBody(_mMainBean, userInfo),
            appBar: new AppBar(
              leading: new Container(
                child: new IconButton(
                  icon: new Icon(Icons.settings),
                  onPressed: () {
                    showMyDialog(context);
                  },
                ),
              ),
              actions: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: new Icon(Icons.message),
                ),
              ],
              title: userInfo == null
                  ? new Text('未加载')
                  : new Text(userInfo.user_name),
              centerTitle: true,
            ),
          );
  }

  showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Dialog Title"),
            content: new Text("This is my content"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  void getData() {
    Map<String, String> map = new Map();
    map["city"] = 'Beijing';
    map["user_id"] = '10072491';
    map["channel"] = 'mi';
    map["sign"] = '40b0c368ea163385f5aba9c885cb3e83';
    map["version"] = '4.5.7';
    map["uuid"] = 'ffffffff-d33b-3794-ffff-ffff8546fc17';
    map["platform"] = 'android';
    map['jwt'] =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NDg2NTUxMzYsInVzZXJpZCI6IjEwMDcyNDkxIn0.11a8JFBWL1ecZ-LYCts5YJMRwi3Yi1pR9YMpKfSD30o';

    ///添加中间
    HttpUtil.get(Api.account_edit_url, (data) {
      if (data != null) {
        List<dynamic> responseJson = data;
        var address = new AccountEditBean.fromJson(responseJson);
//        print("格式化数据：：" + data['MenuBean']);
        getUserData(address);
      }
    }, params: map);

    ///获取用户信息
  }

  Future getUserData(AccountEditBean main) async {
    final SharedPreferences prefs = await _prefs;
    var data = prefs.getString("data");
    if (data != null) {
      print("获取本地数据成功，开始：" + data.toString());
      Map<String, dynamic> responseJson = json.decode(data);
      print("获取本地数据成功，结束：" + responseJson.toString());
      AccountUserInfoBean bean = new AccountUserInfoBean.fromJson(responseJson);

      setState(() {
        userInfo = bean;
        _mMainBean = main.title[0];
        print("本地数据处理成功：" + bean.toString());
      });
    }

//    Map<String, String> map = new Map();
//    map["city"] = 'Beijing';
//    map["user_id"] = '10072491';
//    map["channel"] = 'mi';
//    map["sign"] = '40b0c368ea163385f5aba9c885cb3e83';
//    map["version"] = '4.5.7';
//    map["uuid"] = 'ffffffff-d33b-3794-ffff-ffff8546fc17';
//    map["platform"] = 'android';
//    map['jwt'] =
//        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NDg2NTUxMzYsInVzZXJpZCI6IjEwMDcyNDkxIn0.11a8JFBWL1ecZ-LYCts5YJMRwi3Yi1pR9YMpKfSD30o';
//
//    ///添加中间
//    HttpUtil.get(Api.account_user_infor_url, (data) {
//      if (data != null) {
//        Map<String, dynamic> responseJson = data;
//        var address = new AccountUserInfoBean.fromJson(responseJson);
////        print("格式化数据：：" + data['MenuBean']);
//        setState(() {
//          userInfo = address;
//          print("数据多少啊：：  ");
//        });
//      }
//    }, params: map);
  }
}

class MainBody extends StatelessWidget {
  List<Widget> itemList = [];
  var mMainBean;
  var userInfo;

  MainBody(this.mMainBean, this.userInfo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Container(
            height: window.physicalSize.height / 5,
            width: window.physicalSize.width,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.fill, // 填满
                image: new ExactAssetImage(
                  'assets/images/default_indi_bg.png',
                ),
              ),
            ),
            child: new Padding(
              padding: const EdgeInsets.only(top: 100),
              child: new Column(
                children: <Widget>[
                  new ClipOval(
                    child: new FadeInImage.assetNetwork(
                      placeholder: "/assets/images/time.jpeg",
                      //预览图
                      image: userInfo.web_url,
                      width: 60.0,
                      height: 60.0,
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: new Text(userInfo.user_name),
                  ),

                  ///下面是编辑框
                  new Container(
                    height: window.physicalSize.width / 10,
                    width: window.physicalSize.width / 10,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(3.0)),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: window.physicalSize.width / 13,
                          width: window.physicalSize.width / 10,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.fill, // 填满
                              image: new NetworkImage(
                                mMainBean.picture,
                              ),
                            ),
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
//                                color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(3.0)),

                                ///小编辑框
                                child: new Row(
                                  children: <Widget>[
                                    new Image.asset(
                                      'assets/images/diary_icon.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    new Text("制作小记")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Text(
                          mMainBean.content,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///一条分割线
          new Container(
            width: window.physicalSize.width,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
          ),

          ///开始布局下面
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: new Text('我的收藏'),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/center_image_collection.png',
                          width: 20,
                          height: 20,
                        ),
                        new Text('图文'),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/center_reading_collection.png',
                          width: 20,
                          height: 20,
                        ),
                        new Text('文章'),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/center_music_collection.png',
                          width: 20,
                          height: 20,
                        ),
                        new Text('音乐'),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/center_movie_collection.png',
                          width: 20,
                          height: 20,
                        ),
                        new Text('影视'),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/center_radio_collection.png',
                          width: 20,
                          height: 20,
                        ),
                        new Text('电台'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///一条分割线
          new Container(
            width: window.physicalSize.width,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
          ),

          ///我的关注
          new Container(
            margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: new Row(
              children: <Widget>[
                new Icon(Icons.people),
                new Expanded(
                    child: new Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: new Text('我的关注'),
                )),
                new Icon(Icons.chevron_right),
              ],
            ),
          ),

          ///一条分割线
          new Container(
            width: window.physicalSize.width,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
          ),

          ///歌单
          new Container(
            margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: new Row(
              children: <Widget>[
                new Icon(Icons.music_video),
                new Expanded(
                    child: new Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: new Text('歌单'),
                )),
                new Icon(Icons.chevron_right),
              ],
            ),
          ),

          ///一条分割线
          new Container(
            width: window.physicalSize.width,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
