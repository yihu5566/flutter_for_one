import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_one/http/api.dart';
import 'package:flutter_for_one/http/http_util.dart';
import 'package:flutter_for_one/ui/all/classify_details_bean.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';

class ClassifyDetails extends StatefulWidget {
  String item_id;
  String title;

  ClassifyDetails(this.item_id, this.title);

  @override
  State<StatefulWidget> createState() {
    return new ClassifyDetailsState(title, item_id);
  }
}

class ClassifyDetailsState extends State<ClassifyDetails> {
  String item_id;
  String title;
  ClassifyDetailsBean _bean;
  String _webUrl = '';
  final String fileName = 'wenshan_details.html';

  ClassifyDetailsState(this.title, this.item_id);

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
    HttpUtil.getNoDispose(Api.classify_DETAILS_URL + '/' + item_id, (data) {
      if (data != null) {
        Map<String, dynamic> responseJson = data;
        var address = new ClassifyDetailsBean.fromJson(responseJson);
        print("格式化数据：：" + responseJson['category']);

        ///写本地文件
        _writeDataFile(address.html_content);
        setState(() {
          _bean = address;
        });
      }
    }, params: map);
  }

  void _writeDataFile(String data) async {
    File file = await _getLocalHtmlFile();
    File afterFile = await file.writeAsString(data);
    setState(() {
      _webUrl = afterFile.uri.toString();
    });
    print('weburl ==== $_webUrl');
  }

  Future<File> _getLocalHtmlFile() async {
// 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
// 返回本地文件目录
    return new File('$dir/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    // WebviewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return new Container(
      child: new Stack(
        overflow: Overflow.visible,
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          new WebviewScaffold(
            appBar: new AppBar(
              title: new Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: _bean == null
                      ? new Row(
                          children: <Widget>[
                            new Text(title),
                            new Icon(Icons.keyboard_arrow_down),
                            new CircularProgressIndicator(),

                          ],
                        )
                      : new Row(
                          children: <Widget>[
                            new Text(title),
                            new Icon(Icons.keyboard_arrow_down),
                          ],
                        )),
            ),
            withLocalUrl: true,
            withLocalStorage: true,
            url: _webUrl,
            withJavascript: true,
            withZoom: true,
          ),
        ],
      ),
    );
  }

  showTopDialog() {
    showCupertinoModalPopup<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text(''),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('图文'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: new Text('问答'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: new Text('阅读'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: new Text('连载'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: new Text('影视'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  @override
  void dispose() {
    // 回收相关资源
    // Every listener should be canceled, the same should be done with this stream.
    super.dispose();
  }
}
