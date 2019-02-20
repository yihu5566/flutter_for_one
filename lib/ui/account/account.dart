import 'dart:ui';

import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new MainAccount(),
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
        title: new Text("飞翔的鲨鱼"),
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
}

class MainAccount extends StatelessWidget {
  List<Widget> itemList = [];

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
                      image:
                          "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3463668003,3398677327&fm=58",
                      width: 60.0,
                      height: 60.0,
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: new Text("飞翔的鲨鱼"),
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
                              image: new ExactAssetImage(
                                'assets/images/center_bg.png',
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
                          "读王小波的寻找无双",
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
