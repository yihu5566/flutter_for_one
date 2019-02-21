import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_one/http/api.dart';
import 'package:flutter_for_one/http/http_util.dart';
import 'package:flutter_for_one/ui/index/article_details_bean.dart';

import 'package:html/parser_console.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetails extends StatefulWidget {
  String item_id;
  String title;

  ArticleDetails(this.item_id, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ArticleDetailsState(title, item_id);
  }
}

class ArticleDetailsState extends State<ArticleDetails> {
  String item_id;
  String title;
  ArticleDetailsBean _bean;

  ArticleDetailsState(this.title, this.item_id);

  @override
  void initState() {
    ///获取url然后跳转
    Map<String, String> map = new Map();
    map["user_id"] = '10072491';
    map["channel"] = 'yingyongbao';
    map["sign"] = 'd7736a4befa815dd1aed3fb00a50f2c0';
    map["version"] = '4.5.6';
    map["uuid"] = 'ffffffff-d33b-3794-ffff-ffff8546fc17';
    map["platform"] = 'android';
    HttpUtil.get(Api.ARTICLE_DETAILS_URL + '/' + item_id, (data) {
      if (data != null) {
        Map<String, dynamic> responseJson = data;
        var address = new ArticleDetailsBean.fromJson(responseJson);
        print("格式化数据：：" + responseJson['id']);
        setState(() {
          _bean = address;
        });
      }
    }, params: map);
  }

  @override
  Widget build(BuildContext context) {
    // WebviewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(title),
        ),
        body: _bean == null
            ? new Center(
                child: new Text('数据加载中...'),
              )
            : new SingleChildScrollView(
                child: new Padding(
                  padding: const EdgeInsets.all(4),
                  child: new Html(data: _bean.html_content),
                ),
              ));
  }

  @override
  void dispose() {
    // 回收相关资源
    // Every listener should be canceled, the same should be done with this stream.
    super.dispose();
  }
}
