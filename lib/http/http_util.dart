import 'dart:convert';

import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/http/base_res.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpUtil<T> {
  static const String GET = "get";
  static const String POST = "post";

  static get(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = Api.Base_Url + url;
    }
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    await _request(url, callback,
        method: GET, headers: headers, errorCallback: errorCallback);
  }

  ///发起请求
  static Future _request(String url, Function callback,
      {String method,
      Map<String, String> headers,
      Map<String, String> params,
      Function errorCallback}) async {
    int errorCode; //错误吗
    String errorMsg;
    var data; //数据
    try {
      Map<String, String> headerMap = headers == null ? new Map() : headers;
      Map<String, String> paramMap = params == null ? new Map() : params;
      http.Response res;
      if (POST == method) {
        print("POST:URL=" + url);
        print("POST:BODY=" + paramMap.toString());
        res = await http.post(url, headers: headerMap, body: paramMap);
      } else {
        print("GET:URL=" + url);
        res = await http.get(url, headers: headerMap);
      }
      if (res.statusCode != 200) {
        errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();

        _handError(errorCallback, errorMsg);
        return;
      }
      //以下部分可以根据自己业务需求封装,这里是errorCode>=0则为请求成功,data里的是数据部分
      //记得Map中的泛型为dynamic
      Map<String, dynamic> responseJson = json.decode(res.body);
      BaseRes resp = new BaseRes.fromJson(responseJson);
      errorCode = resp.res;
      data = resp.data;
      // callback返回data,数据类型为dynamic
      //errorCallback中为了方便我直接返回了String类型的errorMsg
      if (callback != null) {
        if (errorCode == 0) {
          callback(data);
        } else {
          _handError(errorCallback, errorMsg);
        }
      }
    } catch (exception) {
      _handError(errorCallback, exception.toString());
    }
  }

  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("errorMsg :" + errorMsg);
  }
}
