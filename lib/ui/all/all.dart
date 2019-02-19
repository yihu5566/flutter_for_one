import 'package:flutter/material.dart';
import 'package:flutter_for_one/http/api.dart';
import 'package:flutter_for_one/http/http_util.dart';
import 'package:flutter_for_one/ui/all/all_item1.dart';
import 'package:flutter_for_one/ui/all/author_item.dart';

class All extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AllState();
  }
}

class AllState extends State<All> {
  List<ListItem> itemList = [];
  var _mMainBean;
  var _mAuthorBean;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<String> getData() {
    Map<String, String> map = new Map();
    map["last_id"] = '0';
    map["user_id"] = '10072491';
    map["channel"] = 'yingyongbao';
    map["sign"] = 'e003f6043691c2b4c24e06a067e2c980';
    map["version"] = '4.5.6';
    map["uuid"] = 'ffffffff-d33b-3794-ffff-ffff8546fc17';
    map["platform"] = 'android';

    itemList.clear();

    ///添加一个头
    itemList.add(new ListHeadItem());

    ///添加中间
    HttpUtil.get(Api.ALl_List_1, (data) {
      if (data != null) {
        List<dynamic> responseJson = data;
        var address = new AllItem.fromJson(responseJson);
//        print("格式化数据：：" + data['MenuBean']);
        setState(() {
          _mMainBean = address.title;
          for (int i = 0; i < _mMainBean.length; i++) {
            itemList.add(
                new ListBodyItem(_mMainBean[i].title, _mMainBean[i].cover));
          }
          print("数据多少啊：：  " + itemList.length.toString());
          _getLastData();
        });
      }
    }, params: map);
  }

  void _getLastData() {
    Map<String, String> map = new Map();
    map["user_id"] = '10072491';
    map["channel"] = 'mi';
    map["sign"] = '3fa61a16215fbfd42a7ea66dc47bf1c9';
    map["version"] = '4.5.7';
    map["uuid"] = 'ffffffff-d33b-3794-ffff-ffff8546fc17';
    map["platform"] = 'android';

    ///添加一个尾巴
    HttpUtil.get(Api.ALl_List_2, (data) {
      if (data != null) {
        List<dynamic> responseJson = data;
        var address = new AuthorItem.fromJson(responseJson);
        setState(() {
          _mAuthorBean = address.title;
          itemList.add(new ListBody2Item(_mAuthorBean));

          print("数据多少啊：：  " + itemList.length.toString());
        });
      }
    }, params: map);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('ONE  IS  All'),
      ),
      body: _rendRow(),
    );
  }

  _rendRow() {
//    var divideListItem =
//        divideTiles(tiles: itemList, context: context, color: Colors.pink)
//            .toList();
    return new Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
        child: new GestureDetector(
          child: new Material(
              elevation: 5.0,
              child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: new ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      final item = itemList[index];
                      if (item is ListHeadItem) {
//                        return new ListViewItem(item.itemData);
                        return divideTiles(
                            tiles: new ViewHeadItem(),
                            context: context,
                            color: Colors.grey);
                      } else if (item is ListBodyItem) {
//                        return new ListViewItem(item.itemData);
                        return divideTiles(
                            tiles: new ViewBodyItem(item.title, item.cover),
                            context: context,
                            color: Colors.grey);
                      } else if (item is ListBody2Item) {
                        print("开始构建最后一个条目：" + item.authorList[0].web_url);
                        return new ViewBody2Item(item.authorList);
                      }
                    },
                    padding: const EdgeInsets.only(bottom: 20),
                  ))),
        ));
  }

  Future<Null> _onRefresh() async {
//    getData();
  }

  static DecoratedBox divideTiles(
      {BuildContext context, @required StatelessWidget tiles, Color color}) {
    assert(tiles != null);
    assert(color != null || context != null);

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context, color: color, width: 5),
      ),
    );

    return new DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: decoration,
      child: tiles,
    );
  }
}

class ViewHeadItem extends StatelessWidget {
  List<String> tabName = ['图文', '问答', '阅读', '连载', '影视', '音乐', '电台'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.all(10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: new Text("分类导航"),
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Container(
                    height: 65,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new ExactAssetImage('assets/images/time.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new Padding(
                      padding: EdgeInsets.only(top: 45, left: 30),
                      child: new Text(
                        tabName[0],
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: new Container(
                    height: 65,
                    margin: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new ExactAssetImage('assets/images/time.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new Padding(
                      padding: EdgeInsets.only(top: 45, left: 30),
                      child: new Text(
                        tabName[1],
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 65,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new ExactAssetImage('assets/images/flower.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new Padding(
                      padding: EdgeInsets.only(top: 45, left: 60),
                      child: new Text(
                        tabName[2],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Container(
                  height: 65,

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new ExactAssetImage('assets/images/time.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
//                  padding: const EdgeInsets.all(25),
                  child: new Padding(
                    padding: EdgeInsets.only(top: 45, left: 30),
                    child: new Text(
                      tabName[3],
                    ),
                  ),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(
                  height: 65,

                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new ExactAssetImage('assets/images/time.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
//                  padding: const EdgeInsets.all(25),
                  child: new Padding(
                    padding: EdgeInsets.only(top: 45, left: 30),
                    child: new Text(
                      tabName[4],
                    ),
                  ),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(
                  height: 65,

                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new ExactAssetImage('assets/images/time.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
//                  padding: const EdgeInsets.all(25),
                  child: new Padding(
                    padding: EdgeInsets.only(top: 45, left: 30),
                    child: new Text(
                      tabName[5],
                    ),
                  ),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new Container(
                  height: 65,

                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new ExactAssetImage('assets/images/time.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
//                  padding: const EdgeInsets.all(25),
                  child: new Padding(
                    padding: EdgeInsets.only(top: 45, left: 30),
                    child: new Text(
                      tabName[6],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ViewBodyItem extends StatelessWidget {
  var _title;
  var _cover;

  ViewBodyItem(String title, String cover) {
    _title = title;
    _cover = cover;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(top: 10),
            child: new Image.network(_cover),
          ),
          new Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: new Text(_title),
          )
        ],
      ),
    );
  }
}

///末尾的条目，里面还是一个list view
class ViewBody2Item extends StatefulWidget {
  List<DataAuthorItem> _title;

  ViewBody2Item(List<DataAuthorItem> title) {
    _title = title;
    print("ViewBody2Item构建：" + _title[0].web_url);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ViewBodyState(_title);
  }
}

class ViewBodyState extends State<ViewBody2Item> {
  var currentIndex = 1;

  List<int> tempList = [];

  List<DataAuthorItem> _title;
  BuildContext mContext;

  ViewBodyState(List<DataAuthorItem> title) {
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return new Container(
      padding: const EdgeInsets.all(20),
      child: new Column(
        children: <Widget>[
          _createItemGroup(_title),
          new GestureDetector(
            onTap: () {
              onCartChanged();
            },
            child: new Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: new Text("换一批"),
            ),
          ),
        ],
      ),
    );
    ;
  }

  void onCartChanged() {
    setState(() {
      print("setState");
    });
  }

  _createItemGroup(List<DataAuthorItem> title) {
    tempList.clear();
    //存入本组需要的角标
    for (int i = 0; i < title.length; i++) {
      if (i < currentIndex * 3 && i >= (currentIndex - 1) * 3) {
        tempList.add(i);
      }

      if (tempList.length == 3) {
        break;
      }
    }
//    print("筛选结果：：" + title[tempList[0]].user_name);
    currentIndex++;
    if (currentIndex * 3 > title.length) {
      currentIndex = 1;
    }
    for (int i = 0; i < tempList.length; i++) {
      print("筛选结果：：" + tempList[i].toString());
    }

    return new Column(
      children: <Widget>[
        _createItem(title[tempList[0]]),
        _createItem(title[tempList[1]]),
        _createItem(title[tempList[2]]),
      ],
    );
  }

  _createItem(DataAuthorItem title) {
    print("构建条目了：" + title.web_url);
    return new Container(
        margin: const EdgeInsets.only(top: 20),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image.network(
                title.web_url,
                width: 40,
                height: 40,
              ),
              new Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(title.user_name),
                      new Text(
                        title.desc,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              new Container(
                padding: const EdgeInsets.all(5),
                child: new Text("关注"),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
                  // 边色与边宽度
                  color: Color(0xffffff),
                ),
              )
            ]));
  }
}

abstract class ListItem {}

// A ListItem that contains data to display a heading
class ListHeadItem implements ListItem {
  ListHeadItem();
}

// A ListItem that contains data to display a message
class ListBodyItem implements ListItem {
  String title;
  String cover;

  ListBodyItem(this.title, this.cover);
}

class ListBody2Item implements ListItem {
  List<DataAuthorItem> authorList;

  ListBody2Item(this.authorList);
}
