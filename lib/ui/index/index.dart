import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_for_one/http/api.dart';
import 'package:flutter_for_one/http/http_util.dart';
import 'package:flutter_for_one/ui/index/MainBean.dart';
import 'package:flutter_for_one/ui/index/article_details_webview.dart';
import 'package:flutter_for_one/ui/index/history_record.dart';
import 'package:flutter_for_one/utils/common_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IndexState();
  }
}

class IndexState extends State<Index> {
  List<ListItem> itemList = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var _mMainBean;
  PageController _pageController;
  int _currentIndex = 0;
  var mContext;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    getData(_currentIndex);
    getUserData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<String> _loadAddressAsset() async {
    return await rootBundle.loadString('assets/jsonfile.json');
  }

  void getUserData() async {
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

    final SharedPreferences prefs = await _prefs;

    var dataLocality = prefs.get('data');
    LogUtil.e(Api.account_user_infor_url);
    if (dataLocality == null) {
      LogUtil.e("本地没有数据，开始网络请求");

      ///添加中间
      HttpUtil.get(Api.account_user_infor_url, (data) {
        if (data != null) {
          var decode = json.encode(data);
          prefs.setString("data", decode);
        }
      }, params: map);
    }
  }

//获取数据
  Future getData(int currentIndex) async {
//    String jsonAddress = await _loadAddressAsset();
//    Map<String, dynamic> jsonResponse = json.decode(jsonAddress);
//    var address = new MainBean.fromJson(jsonResponse);
//    print("格式化数据：：" + address.toString());
//
//    setState(() {
//      _mMainBean = address;
//      for (int i = 0; i < _mMainBean.content_list.length; i++) {
//        itemList.add(new ListViewItem(_mMainBean.content_list[i]));
//      }
//      print("数据获取了啊啊：：" + _mMainBean.toString());
//    });
    //user_id=10072491&channel=yingyongbao&sign=d7736a4befa815dd1aed3fb00a50f2c0&version=4.5.6&uuid=ffffffff-d33b-3794-ffff-ffff8546fc17&platform=android"
    Map<String, String> map = new Map();
    map["user_id"] = '10072491';
    map["channel"] = 'yingyongbao';
    map["sign"] = 'd7736a4befa815dd1aed3fb00a50f2c0';
    map["version"] = '4.5.6';
    map["uuid"] = 'ffffffff-d33b-3794-ffff-ffff8546fc17';
    map["platform"] = 'android';
    var time = DateUtil.getTime(_currentIndex);
//    LogUtil.e(Api.One + time + "/北京");
    HttpUtil.get(Api.One + time + "/北京", (data) {
      if (data != null) {
        Map<String, dynamic> responseJson = data;
        var address = new MainBean.fromJson(responseJson);
//        print("格式化数据：：" + data['MenuBean']);
        setState(() {
          _mMainBean = address;
          itemList.clear();
          for (int i = 0; i < _mMainBean.content_list.length; i++) {
            if (i == 0) {
              itemList.add(
                  new ListHeadItem(_mMainBean.content_list[i], _mMainBean));
            } else {
              var listbody;
              switch (i) {
                case 1:
                  listbody = new ListBodyItem(
                      _mMainBean.content_list[i], "- ONE STORY -");
                  break;
                case 2:
                  listbody = new ListBodyItem(
                      _mMainBean.content_list[i], "- Ba As One -");
                  break;
                case 3:
                  listbody =
                      new ListBodyItem(_mMainBean.content_list[i], "- 问答 -");
                  break;
                case 4:
                  listbody =
                      new ListBodyItem(_mMainBean.content_list[i], "- 连载 -");
                  break;
                case 5:
                  listbody =
                      new ListBodyItem(_mMainBean.content_list[i], "- 音乐 -");
                  break;
                case 6:
                  listbody =
                      new ListBodyItem(_mMainBean.content_list[i], "- 影视 -");
                  break;
              }
              itemList.add(listbody);
            }
          }
          print("数据多少啊：：  " + itemList.length.toString());
        });
      }
    }, params: map);
  }

  @override
  Widget build(BuildContext context) {
//    print("开始布局了：" + _mMainBean.toString());
    mContext = context;
    return Scaffold(
        appBar: _mMainBean == null
            ? AppBar(title: new Text("加载中。。。"))
            : AppBar(
                title: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            mContext,
                            new MaterialPageRoute(
                                builder: (context) => new HistoryRecord()),
                          ).then((result) {
                            print("我是页面返回" + result.toString());
                            if (result == null) return;
                            setState(() {
                              _currentIndex = result as int;
                              getData(_currentIndex);
                              _pageController.jumpToPage(_currentIndex);
                            });
                          });
                        },
                        child: new Text(_mMainBean.weatherBean.date),
                      ),
                    ),
                    _currentIndex == 0
                        ? new Text(
                            "${_mMainBean.weatherBean.city_name}·${_mMainBean.weatherBean.climate} ${_mMainBean.weatherBean.temperature}°C",
                            style: new TextStyle(fontSize: 15),
                          )
                        : new GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                              getData(_currentIndex);
                              _pageController.jumpToPage(_currentIndex);
                            },
                            child: new Text(
                              "今天",
                              style: new TextStyle(fontSize: 15),
                            ),
                          ),
                  ],
                ),
              ),
//
        body: _mMainBean == null
            ? new Center(child: Text("数据加载中。。。"))
            : PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentIndex = index;
//                    print("第几个页面：" + _currentIndex.toString());
                  });
                  getData(index);
                },
                itemBuilder: (BuildContext context, int index) =>
                    _rendRow(context, index),
              ));
  }

  _rendRow(BuildContext context, int index) {
//    var divideListItem =
//        divideTiles(tiles: itemList, context: context, color: Colors.pink)
//            .toList();
    return new Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 2.0),
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
                        tiles:
                            new ListViewHeadItem(item.itemData, item.mMainBean),
                        context: context,
                        color: Colors.grey);
                  } else if (item is ListBodyItem) {
//                        return new ListViewItem(item.itemData);
                    return divideTiles(
                        tiles: new ListViewItem(item.itemData, item.title),
                        context: context,
                        color: Colors.grey);
                  }
                },
                padding: const EdgeInsets.only(bottom: 20),
              ),
            ),
          ),
        ));
  }

  Future<Null> _onRefresh() async {
    getData(_currentIndex);
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

class ListViewItem extends StatelessWidget {
  var content_bean;
  var mtitle;
  BuildContext mContext;

  ListViewItem(content_list, title) {
    content_bean = content_list;
    mtitle = title;
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return new GestureDetector(
      onTap: () {
        onClickItem(content_bean, mtitle);
      },
      child: new Container(
//      alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(mtitle == null ? "" : mtitle),
            new Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    content_bean.title,
                    style: new TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                  new Text(
                    "文/${content_bean.author.user_name}",
                    style: new TextStyle(
                      color: Colors.purple,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: content_bean.img_url,
            ),
            new Text(content_bean.forward),
            new Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text(DateUtil.getDateStrByTimeStr(
                        content_bean.post_date,
                        format: DateFormat.ZH_MONTH_DAY,
                        dateSeparate: "-",
                        timeSeparate: "-")),
                  ),
                  new Image.asset(
                    'assets/images/feeds_laud_default.png',
                    width: 20,
                    height: 20,
                  ),
                  new Text(
                    content_bean.like_count.toString(),
                    style: TextStyle(fontSize: 10, height: -2),
                  ),
                  new Image.asset(
                    'assets/images/feeds_share.png',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickItem(content_bean, mtitle) {
    print("click");
    Navigator.push(
      mContext,
      new MaterialPageRoute(
        builder: (context) =>
            new ArticleDetailsWebView(content_bean.item_id, mtitle),
      ),
    );
  }
}

class ListViewHeadItem extends StatelessWidget {
  var content_bean;
  var mainBean;
  bool isVisible = true;

  ListViewHeadItem(content_list, MainBean mMainBean) {
    content_bean = content_list;
    mainBean = mMainBean;
    LogUtil.e("ListViewHeadItem是啊${mainBean.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: content_bean.img_url,
          ),
          new Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: new Row(
              children: <Widget>[
                new Text(
                  content_bean.title,
                  style: new TextStyle(
                    color: Colors.purple,
                    fontSize: 10.0,
                  ),
                ),
                new Text(
                  "${content_bean.pic_info}",
                  style: new TextStyle(
                    color: Colors.purple,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          new Text(content_bean.forward),
          new Text(content_bean.words_info),
          new Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text("发现"),
                ),
                new Image.asset(
                  'assets/images/diary_icon.png',
                  width: 20,
                  height: 20,
                ),
                new Image.asset(
                  'assets/images/favourite_gray.png',
                  width: 20,
                  height: 20,
                ),
                new Image.asset(
                  'assets/images/feeds_share.png',
                  width: 20,
                  height: 20,
                ),
                new Image.asset(
                  'assets/images/feeds_laud_default.png',
                  width: 20,
                  height: 20,
                ),
                new Text(
                  content_bean.like_count.toString(),
                  style: TextStyle(fontSize: 10, height: -2),
                ),
              ],
            ),
          ),

          ///添加一个新的view
          new GestureDetector(
            onTap: () {
              print("点击了按钮");
            },
            child: new FoldWidget(mainBean, false),
          )
        ],
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <MenuBeanItem>[]]);

  final String title;
  final List<MenuBeanItem> children;
}

class FoldWidget extends StatelessWidget {
  var content_fold;
  bool isVisible;
  Entry data;

  FoldWidget(content_bean, bool visible) {
    content_fold = content_bean;
    isVisible = visible;

    data = new Entry(
      content_fold.menuBean.vol,
      content_fold.menuBean.menuBeanItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(data);
  }

  Widget _buildTiles(Entry root) {
    if (data.children.isEmpty)
      return new Container(
        alignment: Alignment.center,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(child: new Text("一个 VOL ${data.title.toString()}")),
            new Icon(Icons.keyboard_arrow_down),
          ],
        ),
      );
    return new ExpansionTile(
      backgroundColor: Colors.transparent,
      title: new Container(
        alignment: Alignment.center,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("一个 VOL ${data.title.toString()}"),
          ],
        ),
      ),
      children: _buildChildren(data.children),
    );
  }

  List<Widget> _buildChildren(List<MenuBeanItem> root) {
    List<Widget> children = <Widget>[];

    for (int x = 0; x < root.length; x++) {
      children.add(new Container(
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.topLeft,
          child: new Row(
            children: <Widget>[
              new Icon(Icons.arrow_right),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(x == 0
                        ? "ONE STORY"
                        : x == 1
                            ? "Ba As One"
                            : getTitle(int.parse(root[x].content_type))),
                    new Text(root[x].title.toString(),
                        softWrap: true, maxLines: 2),
                  ],
                ),
              )
            ],
          )));
    }
    return children;
  }

  getTitle(int parse) {
    var result;
    switch (parse) {
      case 1:
        result = " ONE STORY ";
        break;
      case 1:
        result = " Ba As One ";
        break;
      case 2:
        result = " 连载 ";
        break;
      case 3:
        result = " 问答 ";
        break;
      case 4:
        result = " 音乐 ";
        break;
      case 5:
        result = " 影视 ";

        break;
    }
    return result;
  }
}

///不同条目的list view
abstract class ListItem {}

// A ListItem that contains data to display a heading
class ListHeadItem implements ListItem {
  final ContentBean itemData;
  final MainBean mMainBean;

  ListHeadItem(this.itemData, this.mMainBean);
}

// A ListItem that contains data to display a message
class ListBodyItem implements ListItem {
  final ContentBean itemData;
  String title;

  ListBodyItem(this.itemData, this.title);
}
