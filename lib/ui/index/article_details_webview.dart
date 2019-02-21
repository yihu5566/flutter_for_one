import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_one/http/api.dart';
import 'package:flutter_for_one/http/http_util.dart';
import 'package:flutter_for_one/ui/index/article_details_bean.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetailsWebView extends StatefulWidget {
  String item_id;
  String title;

  ArticleDetailsWebView(this.item_id, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ArticleDetailsWebViewState(title, item_id);
  }
}

class ArticleDetailsWebViewState extends State<ArticleDetailsWebView> {
  String item_id;
  String title;
  ArticleDetailsBean _bean;

  ArticleDetailsWebViewState(this.title, this.item_id);

  // 标记是否是加载中
  bool loading = true;

  // 标记当前页面是否是我们自定义的回调页面
  bool isLoadingCallbackPage = false;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  // URL变化监听器
  StreamSubscription<String> onUrlChanged;

  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;

  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();

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
        print("格式化数据：：" + responseJson['web_url']);
        setState(() {
          _bean = address;
        });
      }
    }, params: map);
    onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
      switch (state.type) {
        case WebViewState.shouldStart:
          // 准备加载
          setState(() {
            loading = true;
          });
          break;
        case WebViewState.startLoad:
          // 开始加载
          break;
        case WebViewState.finishLoad:
          // 加载完成
          setState(() {
            loading = false;
          });
          if (isLoadingCallbackPage) {
            // 当前是回调页面，则调用js方法获取数据
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // WebviewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return _bean == null
        ? new Center(
            child: new CupertinoActivityIndicator(),
          )
        : new WebviewScaffold(
            key: scaffoldKey,
            url: _bean.web_url,
            appBar: new AppBar(
              centerTitle: true,
              title: new Text(title),
            ),
            // 登录的URL
            withZoom: true,
            // 允许网页缩放
            withLocalStorage: true,
            // 允许LocalStorage
            withJavascript: true, // 允许执行js代码
          );
  }

  @override
  void dispose() {
    // 回收相关资源
    // Every listener should be canceled, the same should be done with this stream.
    onUrlChanged.cancel();
    onStateChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
